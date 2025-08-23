def collatz_len_and_peak(x)
  steps = 0
  peak = x
  n = x

  while n != 1
    if n & 1 != 0
      n = 3 * n + 1
    else
      n >>= 1
    end

    if n > peak
      peak = n
    end
    steps += 1
  end
  [steps, peak]
end

def scan_upto(n)
  best_n = 1
  best_steps = 0
  best_peak = 1
  xor_steps = 0

  (1..n).each do |i|
    steps, peak = collatz_len_and_peak(i)
    xor_steps ^= steps
    if steps > best_steps
      best_n = i
      best_steps = steps
      best_peak = peak
    end
  end

  [best_n, best_steps, best_peak, xor_steps]
end

puts "hello world!"

n = 1_000_000
best_n, best_steps, best_peak, xor_steps = scan_upto(n)
puts "collatz_longest(1..#{n})"
puts "n*=#{best_n}"
puts "steps=#{best_steps}"
puts "peak=#{best_peak}"
puts "xor_steps=#{xor_steps}"