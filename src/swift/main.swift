func collatzLenAndPeak(_ x: UInt64) -> (steps: UInt64, peak: UInt64) {
    var steps: UInt64 = 0
    var peak = x
    var n = x
    
    while n != 1 {
        if n & 1 != 0 {
            n = 3 * n + 1
        } else {
            n >>= 1
        }
        
        if n > peak {
            peak = n
        }
        steps += 1
    }
    
    return (steps, peak)
}

func scanUpto(_ N: UInt64) -> (bestN: UInt64, bestSteps: UInt64, bestPeak: UInt64, xorSteps: UInt64) {
    var bestN: UInt64 = 1
    var bestSteps: UInt64 = 0
    var bestPeak: UInt64 = 1
    var xorSteps: UInt64 = 0
    
    for n in 1...N {
        let result = collatzLenAndPeak(n)
        xorSteps ^= result.steps
        if result.steps > bestSteps {
            bestN = n
            bestSteps = result.steps
            bestPeak = result.peak
        }
    }
    
    return (bestN, bestSteps, bestPeak, xorSteps)
}

print("hello world!")

let N: UInt64 = 1_000_000
let result = scanUpto(N)

print("collatz_longest(1..\(N))")
print("n*=\(result.bestN)")
print("steps=\(result.bestSteps)")
print("peak=\(result.bestPeak)")
print("xor_steps=\(result.xorSteps)")