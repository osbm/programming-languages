import std.stdio;
import std.typecons;

Tuple!(ulong, ulong) collatzLenAndPeak(ulong x) {
    ulong steps = 0;
    ulong peak = x;
    ulong n = x;

    while (n != 1) {
        if (n & 1) {
            n = 3 * n + 1;
        } else {
            n >>= 1;
        }

        if (n > peak) {
            peak = n;
        }
        steps++;
    }

    return tuple(steps, peak);
}

Tuple!(ulong, ulong, ulong, ulong) scanUpto(ulong N) {
    ulong bestN = 1;
    ulong bestSteps = 0;
    ulong bestPeak = 1;
    ulong xorSteps = 0;

    for (ulong n = 1; n <= N; n++) {
        auto result = collatzLenAndPeak(n);
        ulong steps = result[0];
        ulong peak = result[1];

        xorSteps ^= steps;
        if (steps > bestSteps) {
            bestN = n;
            bestSteps = steps;
            bestPeak = peak;
        }
    }

    return tuple(bestN, bestSteps, bestPeak, xorSteps);
}

void main() {
    writeln("hello world!");

    ulong N = 1_000_000;
    auto result = scanUpto(N);
    ulong nstar = result[0];
    ulong steps = result[1];
    ulong peak = result[2];
    ulong checksum = result[3];

    writeln("collatz_longest(1..", N, ")");
    writeln("n*=", nstar);
    writeln("steps=", steps);
    writeln("peak=", peak);
    writeln("xor_steps=", checksum);
}
