def collatz_len_and_peak(x : Int64) : Tuple(Int64, Int64)
  steps = 0_i64
  peak = x
  n = x

  while n != 1
    if n & 1 == 1  # odd
      n = 3_i64 * n + 1_i64
    else  # even
      n = n >> 1
    end
    if n > peak
      peak = n
    end
    steps += 1_i64
  end

  {steps, peak}
end

def scan_upto(limit : Int64) : Tuple(Int64, Int64, Int64, Int64)
  best_n = 1_i64
  best_steps = 0_i64
  best_peak = 1_i64
  xor_steps = 0_i64

  (1_i64..limit).each do |n|
    steps, peak = collatz_len_and_peak(n)
    xor_steps ^= steps
    if steps > best_steps
      best_steps = steps
      best_n = n
      best_peak = peak
    end
  end

  {best_n, best_steps, best_peak, xor_steps}
end

puts "hello world!"

n_limit = 1000000_i64
nstar, steps, peak, checksum = scan_upto(n_limit)
puts "collatz_longest(1..#{n_limit})"
puts "n*=#{nstar}"
puts "steps=#{steps}"
puts "peak=#{peak}"
puts "xor_steps=#{checksum}"