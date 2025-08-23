-module(main).
-export([main/0]).

collatz_len_and_peak(X) ->
    collatz_len_and_peak(X, 0, X).

collatz_len_and_peak(1, Steps, Peak) ->
    {Steps, Peak};
collatz_len_and_peak(N, Steps, Peak) ->
    NewN = case N band 1 of
        1 -> 3 * N + 1;  % odd
        0 -> N bsr 1     % even
    end,
    NewPeak = case NewN > Peak of
        true -> NewN;
        false -> Peak
    end,
    collatz_len_and_peak(NewN, Steps + 1, NewPeak).

scan_upto(Limit) ->
    scan_upto(1, Limit, 1, 0, 1, 0).

scan_upto(N, Limit, BestN, BestSteps, BestPeak, XorSteps) when N > Limit ->
    {BestN, BestSteps, BestPeak, XorSteps};
scan_upto(N, Limit, BestN, BestSteps, BestPeak, XorSteps) ->
    {Steps, Peak} = collatz_len_and_peak(N),
    NewXorSteps = XorSteps bxor Steps,
    {NewBestN, NewBestSteps, NewBestPeak} = case Steps > BestSteps of
        true -> {N, Steps, Peak};
        false -> {BestN, BestSteps, BestPeak}
    end,
    scan_upto(N + 1, Limit, NewBestN, NewBestSteps, NewBestPeak, NewXorSteps).

main() ->
    io:format("hello world!~n"),
    NLimit = 1000000,
    {NStar, Steps, Peak, Checksum} = scan_upto(NLimit),
    io:format("collatz_longest(1..~p)~n", [NLimit]),
    io:format("n*=~p~n", [NStar]),
    io:format("steps=~p~n", [Steps]),
    io:format("peak=~p~n", [Peak]),
    io:format("xor_steps=~p~n", [Checksum]).
