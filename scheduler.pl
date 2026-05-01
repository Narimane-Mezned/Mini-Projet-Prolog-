:- use_module(library(lists)).
:- consult('GL_knowledge_base.pl').
:- consult('constraints.pl').

generate_schedule(Schedule) :-
    ground_truth_sessions(CandidateSessions),
    schedule_sessions(CandidateSessions, [], Schedule),
    write('=== Schedule generated successfully ==='), nl.

schedule_sessions([], Acc, Acc).

schedule_sessions([session(Course, Group, Room, Slot)|Rest], Partial, Final) :-
    check_assignment(Course, Group, Room, Slot, Partial),
    !,
    schedule_sessions(Rest, [session(Course, Group, Room, Slot)|Partial], Final).

schedule_sessions([session(Course, Group, _FailedRoom, _FailedSlot)|Rest], Partial, Final) :-
    write('  [WARN] Session failed fixed assignment, attempting repair: '),
    write(Course), write(' / '), write(Group), nl,
    repair_session(Course, Group, Partial, NewRoom, NewSlot),
    !,
    write('  [OK] Repaired -> '), write(NewRoom), write(' @ '), write(NewSlot), nl,
    schedule_sessions(Rest, [session(Course, Group, NewRoom, NewSlot)|Partial], Final).

schedule_sessions([session(Course, Group, Room, Slot)|Rest], Partial, Final) :-
    write('  [ERROR] Cannot schedule: '), write(Course),
    write(' / '), write(Group), write(' @ '), write(Room), write(' '), write(Slot), nl,
    schedule_sessions(Rest, Partial, Final).

repair_session(Course, Group, Partial, Room, Slot) :-
    course_equipment(Course, ReqEquip),
    room(Room, Cap, RoomEquip, _, _),
    compatible(ReqEquip, RoomEquip),
    group_size(Group, Size),
    Cap >= Size,
    course_instructor(Course, Instr),
    available(Instr, Slot),
    check_assignment(Course, Group, Room, Slot, Partial).

free_generate(Course, Group, Partial, Room, Slot) :-
    repair_session(Course, Group, Partial, Room, Slot).

full_validate(Schedule) :-
    write('=== Running full validation ==='), nl,
    ( validate_schedule(Schedule) ->
        write('[OK] All constraints satisfied.'), nl
    ;
        write('[FAIL] Some constraints violated!'), nl,
        report_violations(Schedule)
    ).

report_violations(Schedule) :-
    check_room_conflicts(Schedule),
    check_group_conflicts(Schedule),
    check_instructor_conflicts(Schedule),
    check_equipment_violations(Schedule),
    check_capacity_violations(Schedule),
    check_energy_violations(Schedule).

check_room_conflicts(Schedule) :-
    ( \+ validate_no_room_conflicts(Schedule) ->
        write('  [!] Room-time conflicts detected'), nl
    ; true ).

check_group_conflicts(Schedule) :-
    ( \+ validate_no_group_conflicts(Schedule) ->
        write('  [!] Group-time conflicts detected'), nl
    ; true ).

check_instructor_conflicts(Schedule) :-
    ( \+ validate_no_instructor_conflicts(Schedule) ->
        write('  [!] Instructor conflicts detected'), nl
    ; true ).

check_equipment_violations(Schedule) :-
    ( \+ validate_all_equipment(Schedule) ->
        write('  [!] Equipment incompatibilities detected'), nl
    ; true ).

check_capacity_violations(Schedule) :-
    ( \+ validate_all_capacity(Schedule) ->
        write('  [!] Capacity violations detected'), nl
    ; true ).

check_energy_violations(Schedule) :-
    ( \+ validate_all_energy(Schedule) ->
        write('  [!] Energy threshold violations detected'), nl
    ; true ).

print_schedule([]) :-
    write('--- End of Schedule ---'), nl.
print_schedule([session(Course, Group, Room, Slot)|Rest]) :-
    format('  Course: ~w | Group: ~w | Room: ~w | Slot: ~w~n',
           [Course, Group, Room, Slot]),
    print_schedule(Rest).

print_group_schedule(Group, Schedule) :-
    format('=== Schedule for group ~w ===~n', [Group]),
    include(session_for_group(Group), Schedule, GroupSessions),
    print_schedule(GroupSessions).

session_for_group(Group, session(_, Group, _, _)).

print_building_day(Building, Day, Schedule) :-
    format('=== ~w on ~w ===~n', [Building, Day]),
    building_daily_sessions(Schedule, Building, Day, Sessions),
    print_schedule(Sessions),
    building_energy_on_day(Schedule, Building, Day, Energy),
    building(Building, _, Threshold),
    format('  Energy: ~w / ~w kWh~n', [Energy, Threshold]).

test_scheduler :-
    nl, write('============================================'), nl,
    write('  SCHEDULER TEST SUITE'), nl,
    write('============================================'), nl, nl,
    write('[TEST 1] Generating schedule from knowledge base...'), nl,
    ground_truth_sessions(Sessions),
    length(Sessions, N),
    format('  Found ~w pre-defined sessions.~n', [N]),
    write('[TEST 2] Validating all sessions...'), nl,
    full_validate(Sessions),
    write('[TEST 3] Energy report for Monday...'), nl,
    test_energy_monday(Sessions),
    write('[TEST 4] Schedule for gl3_1...'), nl,
    print_group_schedule(gl3_1, Sessions),
    write('[TEST 5] Attempting to repair an invalid session...'), nl,
    ( repair_session(gl3_prog_log_c, gl3_1, Sessions, R, S) ->
        format('  Repaired: room=~w, slot=~w~n', [R, S])
    ;
        write('  No repair found (expected if all slots taken).'), nl
    ),
    nl, write('============================================'), nl,
    write('  ALL TESTS DONE'), nl,
    write('============================================'), nl.

test_energy_monday(Schedule) :-
    forall(
        building(B, Name, Threshold),
        (
            building_energy_on_day(Schedule, B, monday, E),
            format('  ~w (~w): ~w / ~w kWh~n', [B, Name, E, Threshold])
        )
    ).

run :-
    write('=== Generating schedule... ==='), nl,
    ground_truth_sessions(Schedule),
    nl, write('=== Validation ==='), nl,
    full_validate(Schedule),
    nl, write('=== Energy Summary (all days) ==='), nl,
    energy_summary(Schedule),
    nl, write('=== Done. Use print_schedule(S) to display all sessions. ==='), nl.

energy_summary(Schedule) :-
    all_days(Days),
    forall(
        (member(Day, Days), building(B, Name, Threshold)),
        (
            building_energy_on_day(Schedule, B, Day, E),
            format('  [~w] ~w (~w): ~w / ~w~n', [Day, Name, B, E, Threshold])
        )
    ).