#include <stdint.h>
#include <stdio.h>

void collatz_len_and_peak(uint64_t x, uint64_t *steps, uint64_t *peak);
void scan_upto(uint64_t N, uint64_t *best_n, uint64_t *best_steps, uint64_t *best_peak, uint64_t *xor_steps);


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