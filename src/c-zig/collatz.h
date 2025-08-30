#ifndef COLLATZ_H
#define COLLATZ_H

#include <stdint.h>

void collatz_len_and_peak(uint64_t x, uint64_t *steps, uint64_t *peak);
void scan_upto(uint64_t N, uint64_t *best_n, uint64_t *best_steps, uint64_t *best_peak, uint64_t *xor_steps);

#endif
