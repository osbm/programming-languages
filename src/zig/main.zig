const std = @import("std");
const print = std.debug.print;

fn collatzLenAndPeak(x: u64) struct { steps: u64, peak: u64 } {
    var steps: u64 = 0;
    var peak: u64 = x;
    var n: u64 = x;

    while (n != 1) {
        if (n % 2 != 0) {
            n = 3 * n + 1;
        } else {
            n = n / 2;
        }

        if (n > peak) {
            peak = n;
        }
        steps += 1;
    }

    return .{ .steps = steps, .peak = peak };
}

fn scanUpto(n: u64) struct { best_n: u64, best_steps: u64, best_peak: u64, xor_steps: u64 } {
    var best_n: u64 = 1;
    var best_steps: u64 = 0;
    var best_peak: u64 = 1;
    var xor_steps: u64 = 0;

    var i: u64 = 1;
    while (i <= n) : (i += 1) {
        const result = collatzLenAndPeak(i);
        const steps = result.steps;
        const peak = result.peak;
        xor_steps ^= steps;
        if (steps > best_steps) {
            best_n = i;
            best_steps = steps;
            best_peak = peak;
        }
    }

    return .{ .best_n = best_n, .best_steps = best_steps, .best_peak = best_peak, .xor_steps = xor_steps };
}

pub fn main() void {
    print("hello world!\n", .{});

    const n: u64 = 1_000_000;
    const result = scanUpto(n);
    print("collatz_longest(1..{d})\n", .{n});
    print("n*={d}\n", .{result.best_n});
    print("steps={d}\n", .{result.best_steps});
    print("peak={d}\n", .{result.best_peak});
    print("xor_steps={d}\n", .{result.xor_steps});
}
