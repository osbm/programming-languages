

def collatz_len_and_peak(x: int) -> tuple[int, int]:

    steps = 0
    peak = x
    n = x
    while n != 1:
        if n & 1:  # odd
            n = 3 * n + 1
        else:      # even
            n >>= 1
        if n > peak:
            peak = n
        steps += 1
    return steps, peak


def scan_upto(N: int):
    best_n = 1
    best_steps = 0
    best_peak = 1
    xor_steps = 0

    for n in range(1, N + 1):
        steps, peak = collatz_len_and_peak(n)
        xor_steps ^= steps
        if steps > best_steps:
            best_steps = steps
            best_n = n
            best_peak = peak

    return best_n, best_steps, best_peak, xor_steps


N = 1_000_000
nstar, steps, peak, checksum = scan_upto(N)
print("hello world")
print(f"collatz_longest(1..{N})")
print(f"n*={nstar} ")
print(f"steps={steps} ")
print(f"peak={peak} ")
print(f"xor_steps={checksum}")
