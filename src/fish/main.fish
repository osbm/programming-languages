#!/usr/bin/env fish

function collatz_len_and_peak
    set n $argv[1]
    set length 0
    set peak $n
    set current $n

    while test $current -ne 1
        if test (math "$current % 2") -eq 0
            set current (math "$current / 2")
        else
            set current (math "$current * 3 + 1")
        end
        set length (math "$length + 1")
        if test $current -gt $peak
            set peak $current
        end
    end

    # Set global variables instead of returning values
    set -g collatz_length $length
    set -g collatz_peak $peak
end

function scan_upto
    set limit $argv[1]
    set max_len 0
    set max_n 0
    set max_peak 0
    set xor_steps 0
    set i 1

    while test $i -le $limit
        collatz_len_and_peak $i
        set len $collatz_length
        set peak $collatz_peak

        if test $len -gt $max_len
            set max_len $len
            set max_n $i
            set max_peak $peak
        end

        set xor_steps (math "$xor_steps ^ $len")
        set i (math "$i + 1")
    end

    # Set global variables instead of returning values
    set -g scan_max_n $max_n
    set -g scan_max_len $max_len
    set -g scan_max_peak $max_peak
    set -g scan_xor_steps $xor_steps
end

function main
    echo "hello world!"
    echo "collatz_longest(1..100000)"

    scan_upto 100000
    set n $scan_max_n
    set steps $scan_max_len
    set peak $scan_max_peak
    set xor_steps $scan_xor_steps

    echo "n*=$n"
    echo "steps=$steps"
    echo "peak=$peak"
    echo "xor_steps=$xor_steps"
end

# Call main function
main
