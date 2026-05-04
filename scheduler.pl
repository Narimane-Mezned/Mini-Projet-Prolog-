:- use_module(library(lists)).
:- consult('GL_knowledge_base.pl').
:- consult('constraints.pl').

tasks_to_schedule(Tasks) :-
    findall(task(C, YG, Equip, Instr),
        (   course(C, _, YG, Type, _, _, Equip, Instr),
            member(Type, [lecture, ci])
        ),
        LectureTasks),
    findall(task(C, G, Equip, Instr),
        (   course(C, _, YG, Type, _, _, Equip, Instr),
            member(Type, [td, tp, combined]),
            group(G, YG, _)
        ),
        GroupTasks),
    append(LectureTasks, GroupTasks, Tasks).

generate_schedule(Schedule) :-
    tasks_to_schedule(Tasks),
    length(Tasks, N),
    format('[INFO] ~w tasks to schedule...~n', [N]),
    schedule_tasks(Tasks, [], Schedule),
    length(Schedule, NS),
    format('[OK] Schedule generated: ~w sessions.~n', [NS]).

schedule_tasks([], Acc, Acc).

schedule_tasks([task(Course, Group, _, _)|Rest], Partial, Final) :-
    course_equipment(Course, ReqEquip),
    room(Room, Cap, RoomEquip, _, _),
    compatible(ReqEquip, RoomEquip),
    group_capacity_ok(Group, Cap),
    course_instructor(Course, Instr),
    available(Instr, Slot),
    check_assignment(Course, Group, Room, Slot, Partial),
    !,
    schedule_tasks(Rest, [session(Course, Group, Room, Slot)|Partial], Final).

schedule_tasks([task(Course, Group, _, _)|Rest], Partial, Final) :-
    format('[WARN] Could not schedule: ~w / ~w — skipped.~n', [Course, Group]),
    schedule_tasks(Rest, Partial, Final).

group_capacity_ok(YearGroup, Cap) :-
    \+ group(YearGroup, _, _),
    findall(S, group(_, YearGroup, S), Sizes),
    Sizes \= [],
    sumlist(Sizes, Total),
    Cap >= Total.

group_capacity_ok(Group, Cap) :-
    group(Group, _, Size),
    Cap >= Size.

group_capacity_ok(Group, Cap) :-
    subgroup(Group, _, _, Size),
    Cap >= Size.

full_validate(Schedule) :-
    write('=== Running full validation ==='), nl,
    ( validate_no_room_conflicts(Schedule) ->
        write('[OK] No room-time conflicts.'), nl
    ;
        write('[FAIL] Room-time conflicts detected!'), nl,
        show_room_conflicts(Schedule)
    ),
    ( validate_no_group_conflicts(Schedule) ->
        write('[OK] No group-time conflicts.'), nl
    ;
        write('[FAIL] Group-time conflicts detected!'), nl
    ),
    ( validate_no_instructor_conflicts(Schedule) ->
        write('[OK] No instructor conflicts.'), nl
    ;
        write('[FAIL] Instructor conflicts detected!'), nl
    ),
    ( validate_all_equipment(Schedule) ->
        write('[OK] All equipment compatible.'), nl
    ;
        write('[FAIL] Equipment incompatibilities!'), nl
    ),
    ( validate_all_instructor_availability(Schedule) ->
        write('[OK] All instructors available.'), nl
    ;
        write('[FAIL] Instructor unavailability detected!'), nl
    ),
    ( validate_all_energy(Schedule) ->
        write('[OK] Energy thresholds respected.'), nl
    ;
        write('[FAIL] Energy threshold violations!'), nl
    ).

show_room_conflicts(Schedule) :-
    forall(
        (member(session(C1,_,R,S), Schedule),
         member(session(C2,_,R,S), Schedule),
         C1 @< C2),
        format('  [!] ~w and ~w in room ~w at slot ~w~n',[C1,C2,R,S])
    ).

print_schedule([]) :-
    write('--- End of Schedule ---'), nl.
print_schedule([session(Course, Group, Room, Slot)|Rest]) :-
    format('  ~w | group=~w | room=~w | slot=~w~n', [Course, Group, Room, Slot]),
    print_schedule(Rest).

print_group_schedule(Group, Schedule) :-
    format('=== Schedule for ~w ===~n', [Group]),
    include(session_for_group(Group), Schedule, Sessions),
    ( Sessions = [] ->
        write('  No sessions found.'), nl
    ;
        print_schedule(Sessions)
    ).

session_for_group(Group, session(_, Group, _, _)).

print_day_schedule(Day, Schedule) :-
    format('=== ~w ===~n', [Day]),
    include(session_on_day(Day), Schedule, DaySessions),
    ( DaySessions = [] ->
        write('  No sessions.'), nl
    ;
        print_schedule(DaySessions)
    ).

session_on_day(Day, session(_, _, _, Slot)) :-
    slot(Slot, Day, _, _, _).

energy_summary(Schedule) :-
    all_days(Days),
    forall(
        (member(Day, Days), building(B, Name, Threshold)),
        (
            building_energy_on_day(Schedule, B, Day, E),
            format('  [~w] ~w (~w): ~w / ~w kWh~n', [Day, Name, B, E, Threshold])
        )
    ).

test_scheduler :-
    nl, write('  SCHEDULER TEST SUITE'), nl,
    nl,

    write('[TEST 1] Generating schedule from scratch...'), nl,
    generate_schedule(Schedule),
    length(Schedule, N),
    format('  Generated ~w sessions.~n~n', [N]),

    write('[TEST 2] Full constraint validation...'), nl,
    full_validate(Schedule), nl,

    write('[TEST 3] Energy report for Monday...'), nl,
    forall(
        building(B, Name, Threshold),
        (   building_energy_on_day(Schedule, B, monday, E),
            format('  ~w (~w): ~w / ~w kWh~n', [B, Name, E, Threshold])
        )
    ), nl,

    write('[TEST 4] Schedule for group gl3_1...'), nl,
    print_group_schedule(gl3_1, Schedule), nl,

    write('[TEST 5] Schedule for gl3 year (lectures/ci)...'), nl,
    print_group_schedule(gl3, Schedule), nl,

    write('[TEST 6] Monday full schedule...'), nl,
    print_day_schedule(monday, Schedule),

    nl,
    write('  ALL TESTS DONE'), nl,
    nl.

run :-
    write('Generating schedule from scratch... '), nl,
    generate_schedule(Schedule),
    nl, write(' Validation '), nl,
    full_validate(Schedule),
    nl, write(' Energy Summary (all days) '), nl,
    energy_summary(Schedule),
    nl, write(' Done. Use generate_schedule(S) to get the schedule. '), nl.