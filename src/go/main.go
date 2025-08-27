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
			defer wg.Done();
			var localresult Results;

			for j := start; j < end; j++ {
				steps, peak := collatzLenAndPeak(j)
				if steps > localresult.steps {
					localresult = Results{n: j, steps: steps, peak: peak, xor: 0}
				}
			}

			results <- localresult
		}(uint64(i)*batchSize+1, uint64((i+1))*batchSize)
	}

	wg.Wait()
	close(results)

	bestN := uint64(0)
	bestSteps := uint64(0)
	bestPeak := uint64(0)

	for res := range results {

		if res.steps > bestSteps {
			bestSteps = res.steps
			bestN = res.n
			bestPeak = res.peak
		}
	}

	fmt.Printf("Number with the longest Collatz sequence under %d is %d with %d steps and peak %d\n", n, bestN, bestSteps, bestPeak)
}