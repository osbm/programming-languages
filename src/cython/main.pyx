cdef (unsigned long long, unsigned long long) collatz_len_and_peak(unsigned long long x):
    cdef unsigned long long steps = 0
    cdef unsigned long long peak = x
    cdef unsigned long long n = x

    while n != 1:
        if n & 1:  # odd
            n = 3 * n + 1
        else:      # even
            n >>= 1
        if n > peak:
            peak = n
        steps += 1

    return (steps, peak)


cdef (unsigned long long, unsigned long long, unsigned long long, unsigned long long) scan_upto(unsigned long long N):
    cdef unsigned long long best_n = 1
    cdef unsigned long long best_steps = 0
    cdef unsigned long long best_peak = 1
    cdef unsigned long long xor_steps = 0
    cdef unsigned long long n, steps, peak

    for n in range(1, N + 1):
        steps, peak = collatz_len_and_peak(n)
        xor_steps ^= steps
        if steps > best_steps:
            best_steps = steps
            best_n = n
            best_peak = peak

    return (best_n, best_steps, best_peak, xor_steps)


def main():
    print("hello world!")

    cdef unsigned long long N = 1_000_000
    cdef unsigned long long nstar, steps, peak, checksum

    nstar, steps, peak, checksum = scan_upto(N)
    print(f"collatz_longest(1..{N})")
    print(f"n*={nstar}")
    print(f"steps={steps}")
    print(f"peak={peak}")
    print(f"xor_steps={checksum}")


if __name__ == "__main__":
    main()