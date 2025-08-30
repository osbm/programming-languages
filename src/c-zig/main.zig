//"bedir Tuğra Karaabalı"
//2025
//bdrtr

// 0.15.1 version // zig build-exe main.zig collatz.c -lc

// Zig is a systems programming language that is 100% compatible with C; it is not meant to replace C, but aims to coexist with it.

const std = @import("std");
const print = std.debug.print;
const c = @cImport(@cInclude("/home/bedir/Documents/vsCode/programming-languages/src/c-zig/collatz.h"));

const Result = struct {
    best_n : u64 = 0,
    best_steps : u64 = 0,
    best_peak : u64 = 0,
    xor_steps : u64 = 0,
};

pub fn main() !void {

    var result = Result{};
    print("hello world!\n", .{});
    const n = 1_000_000;
    c.scan_upto(n, &result.best_n,
     &result.best_steps, &result.best_peak, &result.xor_steps);
     
    print("collatz_longest(1..{d})\n", .{n});
    print("n*={d}\n", .{result.best_n});
    print("steps={d}\n", .{result.best_steps});
    print("peak={d}\n", .{result.best_peak});
    print("xor_steps={d}\n", .{result.xor_steps});

}

