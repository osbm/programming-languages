#!/usr/bin/awk -f

function collatz_len_and_peak(x, result) {
    steps = 0
    peak = x
    n = x
    
    while (n != 1) {
        if (n % 2 == 1) {
            n = 3 * n + 1
        } else {
            n = int(n / 2)
        }
        
        if (n > peak) {
            peak = n
        }
        steps++
    }
    result[1] = steps
    result[2] = peak
}

function scan_upto(N) {
    best_n = 1
    best_steps = 0
    best_peak = 1
    xor_steps = 0
    
    for (n = 1; n <= N; n++) {
        collatz_len_and_peak(n, result)
        steps = result[1]
        peak = result[2]
        xor_steps = xor(xor_steps, steps)
        if (steps > best_steps) {
            best_n = n
            best_steps = steps
            best_peak = peak
        }
    }
    
    print "collatz_longest(1.." N ")"
    print "n*=" best_n
    print "steps=" best_steps
    print "peak=" best_peak
    print "xor_steps=" xor_steps
}

BEGIN {
    print "hello world!"
    scan_upto(1000000)
}