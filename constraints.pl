:- use_module(library(lists)).

equipment_ok(Course, Room) :-
    course_equipment(Course, Req),
    room_equipment(Room, RoomEquip),
    compatible(Req, RoomEquip).


capacity_ok(_Course, Room, Group) :-
    room_capacity(Room, Cap),
    effective_group_size(Group, Size),
    Cap >= Size.


effective_group_size(Group, Size) :-
    group(Group, _, Size).
effective_group_size(Group, Size) :-
    subgroup(Group, _, _, Size).
effective_group_size(YearGroup, Total) :-
    \+ group(YearGroup, _, _),
    \+ subgroup(YearGroup, _, _, _),
    findall(S, group(_, YearGroup, S), Sizes),
    Sizes \= [],
    sumlist(Sizes, Total).

instructor_ok(Course, Slot) :-
    course_instructor(Course, Instr),
    instructor_available_at(Instr, Slot).

no_room_conflict(Room, Slot, PartialSchedule) :-
    \+ member(session(_, _, Room, Slot), PartialSchedule).


group_free_at_slot(Group, Slot, PartialSchedule) :-
    \+ member(session(_, Group, _, Slot), PartialSchedule).


no_parent_group_conflict(Group, Slot, PartialSchedule) :-
    (   parent_group(Group, Parent)
    ->  \+ member(session(_, Parent, _, Slot), PartialSchedule)
    ;   true
    ).

no_subgroup_conflict(Group, Slot, PartialSchedule) :-
    subgroups_of(Group, Subs),
    (   Subs = []
    ->  true
    ;   \+ (member(Sub, Subs),
             member(session(_, Sub, _, Slot), PartialSchedule))
    ).

energy_ok(Room, Slot, PartialSchedule) :-
    day_of_slot(Slot, Day),
    room_building(Room, Building),
    room_energy_cost(Room, Cost),
    ExtraCost is Cost * 1.5,   
    building_energy_on_day(PartialSchedule, Building, Day, CurrentTotal),
    building(Building, _, Threshold),
    CurrentTotal + ExtraCost =< Threshold.

check_assignment(Course, Group, Room, Slot, PartialSchedule) :-
    equipment_ok(Course, Room),                              
    capacity_ok(Course, Room, Group),                        
    instructor_ok(Course, Slot),                             
    no_room_conflict(Room, Slot, PartialSchedule),           
    group_free_at_slot(Group, Slot, PartialSchedule),        
    instructor_free_at_slot(Course, Slot, PartialSchedule),  
    no_parent_group_conflict(Group, Slot, PartialSchedule),
    no_subgroup_conflict(Group, Slot, PartialSchedule),      
    energy_ok(Room, Slot, PartialSchedule). 

validate_no_room_conflicts(Schedule) :-
    \+ (member(session(C1, _, R, S), Schedule),
        member(session(C2, _, R, S), Schedule),
        C1 \= C2).


validate_no_group_conflicts(Schedule) :-
    \+ (member(session(C1, G, _, S), Schedule),
        member(session(C2, G, _, S), Schedule),
        C1 \= C2).


validate_no_instructor_conflicts(Schedule) :-
    \+ (member(session(C1, _, _, S), Schedule),
        member(session(C2, _, _, S), Schedule),
        C1 \= C2,
        course_instructor(C1, I),
        course_instructor(C2, I)).


validate_all_equipment(Schedule) :-
    \+ (member(session(C, _, R, _), Schedule),
        \+ equipment_ok(C, R)).

validate_all_capacity(Schedule) :-
    \+ (member(session(C, G, R, _), Schedule),
        \+ capacity_ok(C, R, G)).

validate_all_instructor_availability(Schedule) :-
    \+ (member(session(C, _, _, S), Schedule),
        \+ instructor_ok(C, S)).

validate_all_energy(Schedule) :-
    all_days(Days),
    findall(B, building(B, _, _), Buildings),
    \+ (member(B, Buildings),
        member(D, Days),
        \+ energy_within_threshold(Schedule, B, D)).

validate_schedule(Schedule) :-
    validate_no_room_conflicts(Schedule),
    validate_no_group_conflicts(Schedule),
    validate_no_instructor_conflicts(Schedule),
    validate_all_equipment(Schedule),
    validate_all_capacity(Schedule),
    validate_all_instructor_availability(Schedule),
    validate_all_energy(Schedule).


instructor_free_at_slot(Course, Slot, PartialSchedule) :-
    course_instructor(Course, Instr),
    \+ (member(session(OtherCourse, _, _, Slot), PartialSchedule),
        course_instructor(OtherCourse, Instr)).