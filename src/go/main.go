package main

import "fmt"

func collatzLenAndPeak(x uint64) (uint64, uint64) {
	steps := uint64(0)
	peak := x
	n := x

	for n != 1 {
		if n&1 != 0 {
			n = 3*n + 1
		} else {
			n >>= 1
		}

		if n > peak {
			peak = n
		}
		steps++
	}
	return steps, peak
}

func scanUpto(n uint64) (uint64, uint64, uint64, uint64) {
	bestN := uint64(1)
	bestSteps := uint64(0)
	bestPeak := uint64(1)
	xorSteps := uint64(0)

	for i := uint64(1); i <= n; i++ {
		steps, peak := collatzLenAndPeak(i)
		xorSteps ^= steps
		if steps > bestSteps {
			bestN = i
			bestSteps = steps
			bestPeak = peak
		}
	}

	return bestN, bestSteps, bestPeak, xorSteps
}

func main() {
	fmt.Println("hello world!")

	n := uint64(1_000_000)
	bestN, bestSteps, bestPeak, xorSteps := scanUpto(n)
	fmt.Printf("collatz_longest(1..%d)\n", n)
	fmt.Printf("n*=%d\n", bestN)
	fmt.Printf("steps=%d\n", bestSteps)
	fmt.Printf("peak=%d\n", bestPeak)
	fmt.Printf("xor_steps=%d\n", xorSteps)
}