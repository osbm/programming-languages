def collatzLenAndPeak(long x) {
    long steps = 0
    long peak = x
    long n = x
    
    while (n != 1) {
        if (n & 1) {
            n = 3 * n + 1
        } else {
            n >>= 1
        }
        
        if (n > peak) {
            peak = n
        }
        steps++
    }
    
    return [steps, peak]
}

def scanUpto(long N) {
    long bestN = 1
    long bestSteps = 0
    long bestPeak = 1
    long xorSteps = 0
    
    for (long n = 1; n <= N; n++) {
        def result = collatzLenAndPeak(n)
        long steps = result[0]
        long peak = result[1]
        xorSteps ^= steps
        if (steps > bestSteps) {
            bestN = n
            bestSteps = steps
            bestPeak = peak
        }
    }
    
    return [bestN, bestSteps, bestPeak, xorSteps]
}

println "hello world!"

long N = 1_000_000
def result = scanUpto(N)
long bestN = result[0]
long bestSteps = result[1]
long bestPeak = result[2]
long xorSteps = result[3]

println "collatz_longest(1..${N})"
println "n*=${bestN}"
println "steps=${bestSteps}"
println "peak=${bestPeak}"
println "xor_steps=${xorSteps}"