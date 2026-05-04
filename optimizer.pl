:- use_module(library(lists)).
:- consult('GL_knowledge_base.pl').
:- consult('constraints.pl').
:- consult('scheduler.pl').

total_energy_score(Schedule, Score) :-
    total_weekly_energy(Schedule, Score).

daily_imbalance_score(Schedule, Imbalance) :-
    all_days(Days),
    findall(DayEnergy,
        (   member(Day, Days),
            day_total_energy(Schedule, Day, DayEnergy),
            DayEnergy > 0
        ),
        DayEnergies),
    ( DayEnergies = [] ->
        Imbalance = 0
    ;
        max_list(DayEnergies, Emax),
        min_list(DayEnergies, Emin),
        Imbalance is Emax - Emin
    ).

day_total_energy(Schedule, Day, Total) :-
    findall(B, building(B, _, _), Buildings),
    findall(E,
        (member(B, Buildings),
         building_energy_on_day(Schedule, B, Day, E)),
        Energies),
    sumlist(Energies, Total).

room_usage_variance(Schedule, Variance) :-
    findall(R, room(R, _, _, _, _), AllRooms),
    length(AllRooms, M),
    M > 0,
    maplist(room_usage_count(Schedule), AllRooms, Usages),
    sumlist(Usages, TotalUsage),
    Mu is TotalUsage / M,
    maplist(squared_diff(Mu), Usages, Diffs),
    sumlist(Diffs, SumDiffs),
    Variance is SumDiffs / M.

room_usage_count(Schedule, Room, Count) :-
    include(session_in_room(Room), Schedule, Sessions),
    length(Sessions, Count).

session_in_room(Room, session(_, _, Room, _)).

squared_diff(Mu, Usage, Diff) :-
    Diff is (Usage - Mu) * (Usage - Mu).

weight(energy,    0.5).
weight(imbalance, 0.3).
weight(variance,  0.2).

composite_score(Schedule, Score) :-
    total_energy_score(Schedule, Energy),
    daily_imbalance_score(Schedule, Imbalance),
    room_usage_variance(Schedule, Variance),
    weight(energy,    W1),
    weight(imbalance, W2),
    weight(variance,  W3),
    Score is W1 * Energy + W2 * Imbalance + W3 * Variance.

evaluate_schedule(Schedule, report(Energy, Imbalance, Variance, Composite)) :-
    total_energy_score(Schedule, Energy),
    daily_imbalance_score(Schedule, Imbalance),
    room_usage_variance(Schedule, Variance),
    weight(energy,    W1),
    weight(imbalance, W2),
    weight(variance,  W3),
    Composite is W1 * Energy + W2 * Imbalance + W3 * Variance.

better_schedule(S1, S2, Best) :-
    composite_score(S1, Score1),
    composite_score(S2, Score2),
    ( Score1 =< Score2 -> Best = S1 ; Best = S2 ).

best_of_list([S], S, Score) :-
    composite_score(S, Score).
best_of_list([S1, S2|Rest], Best, BestScore) :-
    better_schedule(S1, S2, Candidate),
    best_of_list([Candidate|Rest], Best, BestScore).

best_schedule(Schedule, Score) :-
    generate_schedule(Schedule),
    composite_score(Schedule, Score).

print_report(Schedule) :-
    evaluate_schedule(Schedule, report(Energy, Imbalance, Variance, Composite)),
    nl,
    
    write('        OPTIMIZATION REPORT               '), nl,
    
    format('  Total Weekly Energy   : ~4f kWh~n', [Energy]),
    format('  Daily Imbalance       : ~4f kWh~n', [Imbalance]),
    format('  Room Usage Variance   : ~4f~n',     [Variance]),
    
    format('  Composite Score       : ~4f~n',     [Composite]),
    weight(energy, W1), weight(imbalance, W2), weight(variance, W3),
    format('  Weights: Energy=~w, Imbalance=~w, Variance=~w~n', [W1, W2, W3]),
    nl,
    write('  Per-Day Energy Breakdown '), nl,
    print_daily_energy(Schedule),
    nl,
    write('  Per-Building Energy vs Threshold '), nl,
    print_building_energy(Schedule).

print_daily_energy(Schedule) :-
    all_days(Days),
    forall(
        member(Day, Days),
        (   day_total_energy(Schedule, Day, E),
            format('    ~w : ~4f kWh~n', [Day, E])
        )
    ).

print_building_energy(Schedule) :-
    forall(
        building(B, Name, Threshold),
        (
            findall(E,
                (all_days(Days), member(Day, Days),
                 building_energy_on_day(Schedule, B, Day, E)),
                Es),
            sumlist(Es, TotalB),
            WeeklyThresh is Threshold * 6,
            format('    ~w (~w): ~4f / ~w kWh/week~n', [Name, B, TotalB, WeeklyThresh])
        )
    ).

print_room_usage(Schedule) :-
    nl, write(' Room Usage Report :'), nl,
    findall(R, room(R, _, _, _, _), Rooms),
    forall(
        member(R, Rooms),
        (   room_usage_count(Schedule, R, Count),
            (   Count > 0
            ->  room(R, Cap, Equip, Building, _),
                format('  ~w | building=~w | equip=~w | cap=~w | sessions=~w~n',
                       [R, Building, Equip, Cap, Count])
            ;   true
            )
        )
    ).

compare_two(S1, Name1, S2, Name2) :-
    composite_score(S1, Score1),
    composite_score(S2, Score2),
    format('~n=== Comparing ~w vs ~w ===~n', [Name1, Name2]),
    format('  ~w composite score: ~4f~n', [Name1, Score1]),
    format('  ~w composite score: ~4f~n', [Name2, Score2]),
    ( Score1 =< Score2 ->
        format('  >>> WINNER: ~w (lower score = better)~n', [Name1])
    ;
        format('  >>> WINNER: ~w (lower score = better)~n', [Name2])
    ).

test_optimizer :-
    nl, 
    write('  OPTIMIZER TEST SUITE'), nl,
    nl,
    write('[STEP] Generating valid schedule...'), nl,
    generate_schedule(Schedule),
    length(Schedule, N),
    format('[INFO] Working with ~w sessions.~n~n', [N]),
    write('[TEST 1] Total weekly energy...'), nl,
    total_energy_score(Schedule, Energy),
    format('  Total energy: ~4f kWh~n~n', [Energy]),
    write('[TEST 2] Daily imbalance...'), nl,
    daily_imbalance_score(Schedule, Imbalance),
    format('  Daily imbalance: ~4f kWh~n~n', [Imbalance]),
    write('[TEST 3] Room usage variance...'), nl,
    room_usage_variance(Schedule, Variance),
    format('  Room variance: ~4f~n~n', [Variance]),
    write('[TEST 4] Composite score...'), nl,
    composite_score(Schedule, Score),
    format('  Composite score: ~4f~n~n', [Score]),
    write('[TEST 5] Full optimization report...'), nl,
    print_report(Schedule),
    write('[TEST 6] Room usage report...'), nl,
    print_room_usage(Schedule),
    nl, 
    write('  ALL OPTIMIZER TESTS DONE'), nl.

optimize :-
    write(' Generating valid schedule... '), nl,
    generate_schedule(Schedule),
    write(' Running Optimizer '), nl,
    print_report(Schedule),
    nl,
    composite_score(Schedule, BestScore),
    format('Best composite score: ~4f~n', [BestScore]).