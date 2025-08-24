#!/bin/bash

collatz_len_and_peak() {
    local x=$1
    local steps=0
    local peak=$x
    local n=$x

    while [ $n -ne 1 ]; do
        if [ $((n & 1)) -eq 1 ]; then  # odd
            n=$((3 * n + 1))
        else  # even
            n=$((n >> 1))
        fi
        if [ $n -gt $peak ]; then
            peak=$n
        fi
        steps=$((steps + 1))
    done

    echo "$steps $peak"
}

scan_upto() {
    local N=$1
    local best_n=1
    local best_steps=0
    local best_peak=1
    local xor_steps=0

    for ((n=1; n<=N; n++)); do
        read steps peak <<< "$(collatz_len_and_peak $n)"
        xor_steps=$((xor_steps ^ steps))
        if [ $steps -gt $best_steps ]; then
            best_steps=$steps
            best_n=$n
            best_peak=$peak
        fi
    done

    echo "$best_n $best_steps $best_peak $xor_steps"
}

echo "hello world!"

N=10000
read nstar steps peak checksum <<< "$(scan_upto $N)"
echo "collatz_longest(1..$N)"
echo "n*=$nstar"
echo "steps=$steps"
echo "peak=$peak"
echo "xor_steps=$checksum"