function collatzLenAndPeak(x) {
    let steps = 0n;
    let peak = x;
    let n = x;

    while (n !== 1n) {
        if (n & 1n) { // odd
            n = 3n * n + 1n;
        } else { // even
            n >>= 1n;
        }

        if (n > peak) {
            peak = n;
        }
        steps++;
    }

    return [steps, peak];
}

function scanUpto(N) {
    let bestN = 1n;
    let bestSteps = 0n;
    let bestPeak = 1n;
    let xorSteps = 0n;

    for (let n = 1; n <= N; n++) {
        const [steps, peak] = collatzLenAndPeak(BigInt(n));
        xorSteps ^= steps;
        if (steps > bestSteps) {
            bestN = BigInt(n);
            bestSteps = steps;
            bestPeak = peak;
        }
    }

    return [bestN, bestSteps, bestPeak, xorSteps];
}

console.log("hello world!");

const N = 1_000_000;
const [nstar, steps, peak, checksum] = scanUpto(N);
console.log(`collatz_longest(1..${N})`);
console.log(`n*=${nstar}`);
console.log(`steps=${steps}`);
console.log(`peak=${peak}`);
console.log(`xor_steps=${checksum}`);
