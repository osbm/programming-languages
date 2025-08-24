proc collatzLenAndPeak(x: uint64): tuple[steps: uint64, peak: uint64] =
  var steps: uint64 = 0
  var peak = x
  var n = x

  while n != 1:
    if (n and 1) != 0:  # odd
      n = 3 * n + 1
    else:               # even
      n = n shr 1

    if n > peak:
      peak = n
    inc steps

  result = (steps, peak)

proc scanUpto(N: uint64): tuple[bestN: uint64, bestSteps: uint64, bestPeak: uint64, xorSteps: uint64] =
  var bestN: uint64 = 1
  var bestSteps: uint64 = 0
  var bestPeak: uint64 = 1
  var xorSteps: uint64 = 0

  for n in 1'u64..N:
    let (steps, peak) = collatzLenAndPeak(n)
    xorSteps = xorSteps xor steps
    if steps > bestSteps:
      bestSteps = steps
      bestN = n
      bestPeak = peak

  result = (bestN, bestSteps, bestPeak, xorSteps)

echo "hello world!"

let N: uint64 = 1_000_000
let (nstar, steps, peak, checksum) = scanUpto(N)
echo "collatz_longest(1..", N, ")"
echo "n*=", nstar
echo "steps=", steps
echo "peak=", peak
echo "xor_steps=", checksum
