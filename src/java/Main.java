public class Main {

    public static long[] collatzLenAndPeak(long x) {
        long steps = 0;
        long peak = x;
        long n = x;

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
        return new long[]{steps, peak};
    }

    public static long[] scanUpto(long n) {
        long bestN = 1;
        long bestSteps = 0;
        long bestPeak = 1;
        long xorSteps = 0;

        for (long i = 1; i <= n; i++) {
            long[] result = collatzLenAndPeak(i);
            long steps = result[0];
            long peak = result[1];
            xorSteps ^= steps;
            if (steps > bestSteps) {
                bestN = i;
                bestSteps = steps;
                bestPeak = peak;
            }
        }

        return new long[]{bestN, bestSteps, bestPeak, xorSteps};
    }

    public static void main(String[] args) {
        System.out.println("hello world!");

        long n = 1_000_000;
        long[] result = scanUpto(n);
        long bestN = result[0];
        long bestSteps = result[1];
        long bestPeak = result[2];
        long xorSteps = result[3];

        System.out.println("collatz_longest(1.." + n + ")");
        System.out.println("n*=" + bestN);
        System.out.println("steps=" + bestSteps);
        System.out.println("peak=" + bestPeak);
        System.out.println("xor_steps=" + xorSteps);
    }
}
