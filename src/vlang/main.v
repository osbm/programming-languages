fn collatz_len_and_peak(x int) (int, int) {
	mut steps := 0
	mut peak := x
	mut n := x

	for n != 1 {
		if n & 1 == 1 { // odd
			n = 3 * n + 1
		} else { // even
			n = n >> 1
		}
		if n > peak {
			peak = n
		}
		steps++
	}

	return steps, peak
}

fn scan_upto(limit int) (int, int, int, int) {
	mut best_n := 1
	mut best_steps := 0
	mut best_peak := 1
	mut xor_steps := 0

	for n in 1..limit + 1 {
		steps, peak := collatz_len_and_peak(n)
		xor_steps ^= steps
		if steps > best_steps {
			best_steps = steps
			best_n = n
			best_peak = peak
		}
	}

	return best_n, best_steps, best_peak, xor_steps
}

fn main() {
	println('hello world!')

	n_limit := 100000
	nstar, steps, peak, checksum := scan_upto(n_limit)
	println('collatz_longest(1..$n_limit)')
	println('n*=$nstar')
	println('steps=$steps')
	println('peak=$peak')
	println('xor_steps=$checksum')
}
