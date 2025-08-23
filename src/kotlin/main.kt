fun collatzLenAndPeak(x: Long): Pair<Long, Long> {
    var steps = 0L
    var peak = x
    var n = x

    while (n != 1L) {
        if (n and 1L != 0L) {
            n = 3 * n + 1
        } else {
            n = n shr 1
        }

        if (n > peak) {
            peak = n
        }
        steps++
    }
    return Pair(steps, peak)
}

fun scanUpto(n: Long): List<Long> {
    var bestN = 1L
    var bestSteps = 0L
    var bestPeak = 1L
    var xorSteps = 0L

    for (i in 1L..n) {
        val (steps, peak) = collatzLenAndPeak(i)
        xorSteps = xorSteps xor steps
        if (steps > bestSteps) {
            bestN = i
            bestSteps = steps
            bestPeak = peak
        }
    }

    return listOf(bestN, bestSteps, bestPeak, xorSteps)
}

fun main() {
    println("hello world!")

    val n = 1_000_000L
    val (bestN, bestSteps, bestPeak, xorSteps) = scanUpto(n)
    println("collatz_longest(1..$n)")
    println("n*=$bestN")
    println("steps=$bestSteps")
    println("peak=$bestPeak")
    println("xor_steps=$xorSteps")
}
