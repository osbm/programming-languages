
sub collatz_len_and_peak {
    my ($x) = @_;
    my $steps = 0;
    my $peak = $x;
    my $n = $x;

    while ($n != 1) {
        if ($n % 2 == 1) {  # odd
            $n = 3 * $n + 1;
        } else {            # even
            $n = $n >> 1;   # bit shift for division by 2
        }
        $peak = $n if $n > $peak;
        $steps++;
    }

    return ($steps, $peak);
}

sub scan_upto {
    my ($N) = @_;
    my $best_n = 1;
    my $best_steps = 0;
    my $best_peak = 1;
    my $xor_steps = 0;

    for my $n (1..$N) {
        my ($steps, $peak) = collatz_len_and_peak($n);
        $xor_steps ^= $steps;
        if ($steps > $best_steps) {
            $best_steps = $steps;
            $best_n = $n;
            $best_peak = $peak;
        }
    }

    return ($best_n, $best_steps, $best_peak, $xor_steps);
}


print "hello world!\n";

my $N = 1000000;
my ($nstar, $steps, $peak, $checksum) = scan_upto($N);

print "collatz_longest(1..$N)\n";
print "n*=$nstar\n";
print "steps=$steps\n";
print "peak=$peak\n";
print "xor_steps=$checksum\n";