#include <iostream>
#include <tuple>
#include <cstdint>

std::tuple<uint64_t, uint64_t> collatz_len_and_peak(uint64_t x) {
    uint64_t steps = 0;
    uint64_t peak = x;
    uint64_t n = x;

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

    return std::make_tuple(steps, peak);
}

std::tuple<uint64_t, uint64_t, uint64_t, uint64_t> scan_upto(uint64_t N) {
    uint64_t best_n = 1;
    uint64_t best_steps = 0;
    uint64_t best_peak = 1;
    uint64_t xor_steps = 0;

    for (uint64_t n = 1; n <= N; n++) {
        auto [steps, peak] = collatz_len_and_peak(n);
        xor_steps ^= steps;
        if (steps > best_steps) {
            best_n = n;
            best_steps = steps;
            best_peak = peak;
        }
    }

    return std::make_tuple(best_n, best_steps, best_peak, xor_steps);
}

int main() {
    std::cout << "hello world!" << std::endl;

    uint64_t N = 1000000;
    auto [best_n, best_steps, best_peak, xor_steps] = scan_upto(N);

    std::cout << "collatz_longest(1.." << N << ")" << std::endl;
    std::cout << "n*=" << best_n << std::endl;
    std::cout << "steps=" << best_steps << std::endl;
    std::cout << "peak=" << best_peak << std::endl;
    std::cout << "xor_steps=" << xor_steps << std::endl;

    return 0;
}
