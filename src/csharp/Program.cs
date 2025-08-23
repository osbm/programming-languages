using System;

class Program
{
    static (ulong steps, ulong peak) CollatzLenAndPeak(ulong x)
    {
        ulong steps = 0;
        ulong peak = x;
        ulong n = x;

        while (n != 1)
        {
            if (n % 2 != 0)
            {
                n = 3 * n + 1;
            }
            else
            {
                n = n / 2;
            }

            if (n > peak)
            {
                peak = n;
            }
            steps++;
        }

        return (steps, peak);
    }

    static (ulong bestN, ulong bestSteps, ulong bestPeak, ulong xorSteps) ScanUpto(ulong limit)
    {
        ulong bestN = 1;
        ulong bestSteps = 0;
        ulong bestPeak = 1;
        ulong xorSteps = 0;

        for (ulong i = 1; i <= limit; i++)
        {
            var (steps, peak) = CollatzLenAndPeak(i);
            xorSteps ^= steps;
            if (steps > bestSteps)
            {
                bestN = i;
                bestSteps = steps;
                bestPeak = peak;
            }
        }

        return (bestN, bestSteps, bestPeak, xorSteps);
    }

    static void Main()
    {
        Console.WriteLine("hello world!");

        ulong n = 1_000_000;
        var (bestN, bestSteps, bestPeak, xorSteps) = ScanUpto(n);
        Console.WriteLine($"collatz_longest(1..{n})");
        Console.WriteLine($"n*={bestN}");
        Console.WriteLine($"steps={bestSteps}");
        Console.WriteLine($"peak={bestPeak}");
        Console.WriteLine($"xor_steps={xorSteps}");
    }
}
