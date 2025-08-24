;; Collatz conjecture implementation in Scheme

;; Import required modules
(use-modules (srfi srfi-60)) ; For bitwise operations

;; Calculate Collatz sequence length and peak
(define (collatz-len-and-peak n)
  (define (helper current length peak)
    (if (= current 1)
        (list length peak)
        (let* ((next (if (even? current)
                        (/ current 2)
                        (+ (* current 3) 1)))
               (new-peak (max current peak)))
          (helper next (+ length 1) new-peak))))
  (helper n 0 n))

;; Scan up to limit to find longest sequence
(define (scan-upto limit)
  (define (helper i max-n max-len max-peak xor-steps)
    (if (> i limit)
        (list max-n max-len max-peak xor-steps)
        (let* ((result (collatz-len-and-peak i))
               (len (car result))
               (peak (cadr result))
               (new-max-n (if (> len max-len) i max-n))
               (new-max-len (if (> len max-len) len max-len))
               (new-max-peak (if (> len max-len) peak max-peak))
               (new-xor-steps (logxor xor-steps len)))
          (helper (+ i 1) new-max-n new-max-len new-max-peak new-xor-steps))))
  (helper 1 0 0 0 0))

;; Main program
(define (main)
  (display "hello world!")
  (newline)
  (display "collatz_longest(1..1000000)")
  (newline)
  (let* ((result (scan-upto 1000000))
         (n (car result))
         (steps (cadr result))
         (peak (caddr result))
         (xor-steps (cadddr result)))
    (display "n*=")
    (display n)
    (newline)
    (display "steps=")
    (display steps)
    (newline)
    (display "peak=")
    (display peak)
    (newline)
    (display "xor_steps=")
    (display xor-steps)
    (newline)))

;; Run main
(main)
