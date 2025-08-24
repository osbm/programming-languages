let collatzLenAndPeak (x: uint64) : uint64 * uint64 =
    let mutable steps = 0UL
    let mutable peak = x
    let mutable n = x

    while n <> 1UL do
        if n &&& 1UL <> 0UL then  // odd
            n <- 3UL * n + 1UL
        else                      // even
            n <- n >>> 1

        if n > peak then
            peak <- n
        steps <- steps + 1UL

    (steps, peak)

let scanUpto (N: uint64) : uint64 * uint64 * uint64 * uint64 =
    let mutable bestN = 1UL
    let mutable bestSteps = 0UL
    let mutable bestPeak = 1UL
    let mutable xorSteps = 0UL

    for n in 1UL .. N do
        let (steps, peak) = collatzLenAndPeak n
        xorSteps <- xorSteps ^^^ steps
        if steps > bestSteps then
            bestN <- n
            bestSteps <- steps
            bestPeak <- peak

    (bestN, bestSteps, bestPeak, xorSteps)

[<EntryPoint>]
let main argv =
    printfn "hello world!"

    let N = 1_000_000UL
    let (nstar, steps, peak, checksum) = scanUpto N
    printfn "collatz_longest(1..%d)" N
    printfn "n*=%d" nstar
    printfn "steps=%d" steps
    printfn "peak=%d" peak
    printfn "xor_steps=%d" checksum

    0
