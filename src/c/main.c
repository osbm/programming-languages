#include <stdio.h>
#include <stdint.h>

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

int main() {
    printf("hello world!\n");

    uint64_t N = 1000000;
    uint64_t best_n, best_steps, best_peak, xor_steps;
    scan_upto(N, &best_n, &best_steps, &best_peak, &xor_steps);
    printf("collatz_longest(1..%lu)\n", N);
    printf("n*=%lu\n", best_n);
    printf("steps=%lu\n", best_steps);
    printf("peak=%lu\n", best_peak);
    printf("xor_steps=%lu\n", xor_steps);

    return 0;
}