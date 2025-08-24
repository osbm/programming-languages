fn collatz_len_and_peak(x i64) (i64, i64) {
	mut steps := i64(0)
	mut peak := x
	mut n := x

	for n != 1 {
		if n & i64(1) == i64(1) { // odd
			n = i64(3) * n + i64(1)
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

fn scan_upto(limit i64) (i64, i64, i64, i64) {
	mut best_n := i64(1)
	mut best_steps := i64(0)
	mut best_peak := i64(1)
	mut xor_steps := i64(0)

	for n in i64(1)..limit + i64(1) {
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

	n_limit := i64(1000000)
	nstar, steps, peak, checksum := scan_upto(n_limit)
	println('collatz_longest(1..$n_limit)')
	println('n*=$nstar')
	println('steps=$steps')
	println('peak=$peak')
	println('xor_steps=$checksum')
}
