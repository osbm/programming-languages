class Main {
    
    static function collatzLenAndPeak(x: Int): {steps: Int, peak: Int} {
        var steps: Int = 0;
        var peak: Int = x;
        var n: Int = x;
        
        while (n != 1) {
            if ((n & 1) != 0) {
                n = 3 * n + 1;
            } else {
                n >>= 1;
            }
            
            if (n > peak) {
                peak = n;
            }
            steps++;
        }
        
        return {steps: steps, peak: peak};
    }
    
    static function scanUpto(N: Int): {bestN: Int, bestSteps: Int, bestPeak: Int, xorSteps: Int} {
        var bestN: Int = 1;
        var bestSteps: Int = 0;
        var bestPeak: Int = 1;
        var xorSteps: Int = 0;
        
        for (n in 1...N+1) {
            var result = collatzLenAndPeak(n);
            xorSteps ^= result.steps;
            if (result.steps > bestSteps) {
                bestN = n;
                bestSteps = result.steps;
                bestPeak = result.peak;
            }
        }
        
        return {bestN: bestN, bestSteps: bestSteps, bestPeak: bestPeak, xorSteps: xorSteps};
    }
    
    static function main(): Void {
        Sys.println("hello world!");
        
        var N: Int = 1000000;
        var result = scanUpto(N);
        
        Sys.println('collatz_longest(1..$N)');
        Sys.println('n*=${result.bestN}');
        Sys.println('steps=${result.bestSteps}');
        Sys.println('peak=${result.bestPeak}');
        Sys.println('xor_steps=${result.xorSteps}');
    }
}