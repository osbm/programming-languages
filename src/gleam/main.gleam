import gleam/io
import gleam/int

// Proper XOR implementation using bit operations
fn xor(a: Int, b: Int) -> Int {
  // Convert to binary representation and XOR bit by bit
  xor_helper(a, b, 0, 1)
}

fn xor_helper(a: Int, b: Int, result: Int, bit_position: Int) -> Int {
  case a == 0 && b == 0 {
    True -> result
    False -> {
      let a_bit = a % 2
      let b_bit = b % 2
      let xor_bit = case a_bit == b_bit {
        True -> 0
        False -> 1
      }
      let new_result = result + xor_bit * bit_position
      xor_helper(a / 2, b / 2, new_result, bit_position * 2)
    }
  }
}

fn collatz_len_and_peak(x: Int) -> #(Int, Int) {
  collatz_len_and_peak_(x, 0, x)
}

fn collatz_len_and_peak_(n: Int, steps: Int, peak: Int) -> #(Int, Int) {
  case n {
    1 -> #(steps, peak)
    _ -> {
      let next_n = case n % 2 == 1 {
        True -> 3 * n + 1
        False -> n / 2
      }
      let new_peak = case next_n > peak {
        True -> next_n
        False -> peak
      }
      collatz_len_and_peak_(next_n, steps + 1, new_peak)
    }
  }
}

fn scan_upto(n: Int) -> #(Int, Int, Int, Int) {
  scan_upto_(1, n, 1, 0, 1, 0)
}

fn scan_upto_(i: Int, n: Int, best_n: Int, best_steps: Int, best_peak: Int, xor_steps: Int) -> #(Int, Int, Int, Int) {
  case i > n {
    True -> #(best_n, best_steps, best_peak, xor_steps)
    False -> {
      let #(steps, peak) = collatz_len_and_peak(i)
      let new_xor_steps = xor(xor_steps, steps)
      let #(new_best_n, new_best_steps, new_best_peak) =
        case steps > best_steps {
          True -> #(i, steps, peak)
          False -> #(best_n, best_steps, best_peak)
        }
      scan_upto_(i + 1, n, new_best_n, new_best_steps, new_best_peak, new_xor_steps)
    }
  }
}

pub fn main() {
  io.println("hello world!")
  let n = 1_000_000
  let #(best_n, best_steps, best_peak, xor_steps) = scan_upto(n)
  io.println("collatz_longest(1.." <> int.to_string(n) <> ")")
  io.println("n*=" <> int.to_string(best_n))
  io.println("steps=" <> int.to_string(best_steps))
  io.println("peak=" <> int.to_string(best_peak))
  io.println("xor_steps=" <> int.to_string(xor_steps))
}
