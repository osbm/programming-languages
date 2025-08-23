<?php

function collatz_len_and_peak($x) {
    $steps = 0;
    $peak = $x;
    $n = $x;

    while ($n != 1) {
        if ($n & 1 != 0) {
            $n = 3 * $n + 1;
        } else {
            $n >>= 1;
        }

        if ($n > $peak) {
            $peak = $n;
        }
        $steps++;
    }
    return [$steps, $peak];
}

function scan_upto($n) {
    $best_n = 1;
    $best_steps = 0;
    $best_peak = 1;
    $xor_steps = 0;

    for ($i = 1; $i <= $n; $i++) {
        [$steps, $peak] = collatz_len_and_peak($i);
        $xor_steps ^= $steps;
        if ($steps > $best_steps) {
            $best_n = $i;
            $best_steps = $steps;
            $best_peak = $peak;
        }
    }

    return [$best_n, $best_steps, $best_peak, $xor_steps];
}

echo "hello world!\n";

$n = 1_000_000;
[$best_n, $best_steps, $best_peak, $xor_steps] = scan_upto($n);
echo "collatz_longest(1..$n)\n";
echo "n*=$best_n\n";
echo "steps=$best_steps\n";
echo "peak=$best_peak\n";
echo "xor_steps=$xor_steps\n";

?>
