/*
			Bedir T. Karaabalı
			https://github.com/bdrtr
			2025

*/

package main

import (
	"fmt"
	"sync"
)


type Results struct {
	n      uint64
	steps  uint64
	peak   uint64
	xor    uint64
}

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

func main() {
	n := uint64(1_000_000)
	concurrency := 8
	batchSize := n / uint64(concurrency)

	results := make(chan Results, concurrency)
	var wg sync.WaitGroup

	for i := 0; i < concurrency; i++ {
		wg.Add(1)
		go func(start, end uint64) {
			defer wg.Done()

			var localresult Results
			var localXor uint64

			for j := start; j < end; j++ {
				steps, peak := collatzLenAndPeak(j)
				localXor ^= steps
				if steps > localresult.steps {
					localresult = Results{n: j, steps: steps, peak: peak}
				}
			}

			localresult.xor = localXor
			results <- localresult
		}(uint64(i)*batchSize+1, uint64((i+1))*batchSize)
	}

	wg.Wait()
	close(results)

	bestN := uint64(0)
	bestSteps := uint64(0)
	bestPeak := uint64(0)
	xorSteps := uint64(0)

	for res := range results {

		if res.steps > bestSteps {
			bestSteps = res.steps
			bestN = res.n
			bestPeak = res.peak
			
		}

	}

	for i := uint64(1); i <= n; i++ {
		steps, _ := collatzLenAndPeak(i)
		xorSteps ^= steps
	}

	fmt.Printf("collatz_longest(1..%d)\n", n)
	fmt.Printf("n*=%d\n", bestN)
	fmt.Printf("steps=%d\n", bestSteps)
	fmt.Printf("peak=%d\n", bestPeak)
	fmt.Printf("xor_steps=%d\n", xorSteps)

}