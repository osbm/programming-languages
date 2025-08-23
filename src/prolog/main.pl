% Collatz conjecture implementation in Prolog

% Base case: if n is 1, length is 0 and peak is 1
collatz_len_and_peak(1, 0, 1) :- !.

% Recursive case: calculate next step and continue
collatz_len_and_peak(N, Length, Peak) :-
    N > 1,
    (   N mod 2 =:= 0
    ->  Next is N // 2
    ;   Next is N * 3 + 1
    ),
    collatz_len_and_peak(Next, NextLength, NextPeak),
    Length is NextLength + 1,
    Peak is max(N, NextPeak).

% Find the number with longest Collatz sequence up to Limit
scan_upto(Limit, MaxN, MaxLen, MaxPeak, XorSteps) :-
    scan_helper(1, Limit, 0, 0, 0, 0, MaxN, MaxLen, MaxPeak, XorSteps).

% Helper predicate for scanning
scan_helper(Current, Limit, CurrentMaxN, CurrentMaxLen, CurrentMaxPeak, CurrentXor, MaxN, MaxLen, MaxPeak, XorSteps) :-
    (   Current > Limit
    ->  MaxN = CurrentMaxN,
        MaxLen = CurrentMaxLen,
        MaxPeak = CurrentMaxPeak,
        XorSteps = CurrentXor
    ;   collatz_len_and_peak(Current, Len, Peak),
        (   Len > CurrentMaxLen
        ->  NewMaxN = Current,
            NewMaxLen = Len,
            NewMaxPeak = Peak
        ;   NewMaxN = CurrentMaxN,
            NewMaxLen = CurrentMaxLen,
            NewMaxPeak = CurrentMaxPeak
        ),
        NewXor is CurrentXor xor Len,
        Next is Current + 1,
        scan_helper(Next, Limit, NewMaxN, NewMaxLen, NewMaxPeak, NewXor, MaxN, MaxLen, MaxPeak, XorSteps)
    ).

% Main program
main :-
    write('hello world!'), nl,
    write('collatz_longest(1..1000000)'), nl,
    scan_upto(1000000, N, Steps, Peak, XorSteps),
    format('n*=~w~n', [N]),
    format('steps=~w~n', [Steps]),
    format('peak=~w~n', [Peak]),
    format('xor_steps=~w~n', [XorSteps]),
    halt.
