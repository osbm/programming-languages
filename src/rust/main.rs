
fn collatz_len_and_peak(x: u64) -> (u64, u64) {

    let mut steps = 0;
    let mut peak = x;
    let mut n = x;

    while n != 1 {
        if n & 1 != 0 {
            n = 3 * n + 1;
        } else {
            n >>= 1;
        }

        if n > peak {
            peak = n;
        }
        steps += 1;
    }
    (steps, peak)

}

fn scan_upto(n: u64) -> (u64, u64, u64, u64) {
    let mut best_n = 1;
    let mut best_steps = 0;
    let mut best_peak = 1;
    let mut xor_steps = 0;

    for n in 1..=n {
        let (steps, peak) = collatz_len_and_peak(n);
        xor_steps ^= steps;
        if steps > best_steps {
            best_n = n;
            best_steps = steps;
            best_peak = peak;
        }
    }


    (best_n, best_steps, best_peak, xor_steps)
}

fn main() {
    println!("hello world!");

    let n: u64 = 1_000_000;
    let (best_n, best_steps, best_peak, xor_steps) = scan_upto(n);
    println!("collatz_longest(1..{n})");
    println!("n*={best_n}");
    println!("steps={best_steps}");
    println!("peak={best_peak}");
    println!("xor_steps={xor_steps}");
}