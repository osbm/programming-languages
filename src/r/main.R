collatz_len_and_peak <- function(x) {
  steps <- 0
  peak <- x
  n <- x
  
  while (n != 1) {
    if (n %% 2 != 0) {
      n <- 3 * n + 1
    } else {
      n <- n %/% 2
    }
    
    if (n > peak) {
      peak <- n
    }
    steps <- steps + 1
  }
  
  return(c(steps, peak))
}

scan_upto <- function(n) {
  best_n <- 1
  best_steps <- 0
  best_peak <- 1
  xor_steps <- 0
  
  for (i in 1:n) {
    result <- collatz_len_and_peak(i)
    steps <- result[1]
    peak <- result[2]
    xor_steps <- bitwXor(as.integer(xor_steps), as.integer(steps))
    if (steps > best_steps) {
      best_n <- i
      best_steps <- steps
      best_peak <- peak
    }
  }
  
  return(c(best_n, best_steps, best_peak, xor_steps))
}

cat("hello world!\n")

n <- 1000000
result <- scan_upto(n)
best_n <- result[1]
best_steps <- result[2]
best_peak <- result[3]
xor_steps <- result[4]

cat("collatz_longest(1..", n, ")\n", sep="")
cat("n*=", best_n, "\n", sep="")
cat("steps=", best_steps, "\n", sep="")
cat("peak=", best_peak, "\n", sep="")
cat("xor_steps=", xor_steps, "\n", sep="")
