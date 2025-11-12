object Main {
  
  def collatzLenAndPeak(x: Long): (Long, Long) = {
    var steps = 0L
    var peak = x
    var n = x
    
    while (n != 1) {
      if ((n & 1) != 0) {
        n = 3 * n + 1
      } else {
        n >>= 1
      }
      
      if (n > peak) {
        peak = n
      }
      steps += 1
    }
    (steps, peak)
  }
  
  def scanUpto(N: Long): (Long, Long, Long, Long) = {
    var bestN = 1L
    var bestSteps = 0L
    var bestPeak = 1L
    var xorSteps = 0L
    
    for (n <- 1L to N) {
      val (steps, peak) = collatzLenAndPeak(n)
      xorSteps ^= steps
      if (steps > bestSteps) {
        bestN = n
        bestSteps = steps
        bestPeak = peak
      }
    }
    
    (bestN, bestSteps, bestPeak, xorSteps)
  }
  
  def main(args: Array[String]): Unit = {
    println("hello world!")
    
    val N = 1_000_000L
    val (bestN, bestSteps, bestPeak, xorSteps) = scanUpto(N)
    println(s"collatz_longest(1..$N)")
    println(s"n*=$bestN")
    println(s"steps=$bestSteps")
    println(s"peak=$bestPeak")
    println(s"xor_steps=$xorSteps")
  }
}