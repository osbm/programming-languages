def collatz_len_and_peak [n: int] {

	mut steps = 0
	mut peak = $n
	mut current = $n
	while $current != 1 {
		if $current mod 2 == 1 {
			$current = 3 * $current + 1
		} else {
			$current = $current | bits shr 1
		}
		if $current > $peak {
			$peak = $current
		}
		$steps = $steps + 1
	}
	[$steps, $peak]
}
def scan_upto [N: int] {
	mut best_n = 1
	mut best_steps = 0
	mut best_peak = 1
	mut xor_steps = 0

	for n in 1..$N {
		let result = collatz_len_and_peak $n
		let steps = $result.0
		let peak = $result.1
		$xor_steps = $xor_steps | bits xor $steps
		if $steps > $best_steps {
			$best_steps = $steps
			$best_n = $n
			$best_peak = $peak
		}
	}
	[$best_n, $best_steps, $best_peak, $xor_steps]
}
print "hello world!"

let N = 1000000
let result = scan_upto $N
let nstar = $result.0
let steps = $result.1
let peak = $result.2
let xor_steps = $result.3

"collatz_longest(1..number)" | str replace "number" ($N | into string) | print
"nstar=number" | str replace "number" ($nstar | into string) | print
"steps=number" | str replace "number" ($steps | into string) | print
"peak=number" | str replace "number" ($peak | into string) | print
"xor_steps=number" | str replace "number" ($xor_steps | into string) | print