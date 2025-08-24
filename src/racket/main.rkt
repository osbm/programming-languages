#lang racket

(define (collatz-len-and-peak x)
  "Compute the length of Collatz sequence and peak value for number x"
  (let loop ([n x] [steps 0] [peak x])
    (if (= n 1)
        (values steps peak)
        (let ([next-n (if (odd? n)
                          (+ (* 3 n) 1)
                          (/ n 2))])
          (loop next-n
                (+ steps 1)
                (max peak next-n))))))

(define (scan-upto limit)
  "Scan numbers 1 to limit and find the one with longest Collatz sequence"
  (let loop ([i 1] [best-n 1] [best-steps 0] [best-peak 1] [xor-steps 0])
    (if (> i limit)
        (values best-n best-steps best-peak xor-steps)
        (let-values ([(steps peak) (collatz-len-and-peak i)])
          (if (> steps best-steps)
              (loop (+ i 1) i steps peak (bitwise-xor xor-steps steps))
              (loop (+ i 1) best-n best-steps best-peak (bitwise-xor xor-steps steps)))))))

(define (main)
  "Main function"
  (displayln "hello world!")
  (let ([n 1000000])
    (let-values ([(nstar steps peak checksum) (scan-upto n)])
      (printf "collatz_longest(1..~a)~n" n)
      (printf "n*=~a~n" nstar)
      (printf "steps=~a~n" steps)
      (printf "peak=~a~n" peak)
      (printf "xor_steps=~a~n" checksum))))

;; Run the main function
(main)
