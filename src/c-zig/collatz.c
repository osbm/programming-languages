#include "collatz.h"

void collatz_len_and_peak(uint64_t x, uint64_t *steps, uint64_t *peak) {
    *steps = 0;
    *peak = x;
    uint64_t n = x;

    while (n != 1) {
        if (n & 1) {
            n = 3 * n + 1;
        } else {
            n >>= 1;
        }

        if (n > *peak) {
            *peak = n;
        }
        (*steps)++;
    }
}

void scan_upto(uint64_t N, uint64_t *best_n, uint64_t *best_steps, uint64_t *best_peak, uint64_t *xor_steps) {
    *best_n = 1;
    *best_steps = 0;
    *best_peak = 1;
    *xor_steps = 0;

    for (uint64_t n = 1; n <= N; n++) {
        uint64_t steps, peak;
        collatz_len_and_peak(n, &steps, &peak);
        *xor_steps ^= steps;
        if (steps > *best_steps) {
            *best_n = n;
            *best_steps = steps;
            *best_peak = peak;
        }
    }
}
