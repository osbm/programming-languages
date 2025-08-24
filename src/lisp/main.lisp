(defun collatz-len-and-peak (x)
  "Compute the length of Collatz sequence and peak value for number x"
  (let ((steps 0)
        (peak x)
        (n x))
    (loop while (/= n 1) do
      (setf n (if (oddp n)
                  (+ (* 3 n) 1)
                  (/ n 2)))
      (when (> n peak)
        (setf peak n))
      (incf steps))
    (values steps peak)))

(defun scan-upto (limit)
  "Scan numbers 1 to limit and find the one with longest Collatz sequence"
  (let ((best-n 1)
        (best-steps 0)
        (best-peak 1)
        (xor-steps 0))
    (loop for n from 1 to limit do
      (multiple-value-bind (steps peak) (collatz-len-and-peak n)
        (setf xor-steps (logxor xor-steps steps))
        (when (> steps best-steps)
          (setf best-n n
                best-steps steps
                best-peak peak))))
    (values best-n best-steps best-peak xor-steps)))

(defun main ()
  "Main function"
  (format t "hello world!~%")
  (let ((n 1000000))
    (multiple-value-bind (nstar steps peak checksum) (scan-upto n)
      (format t "collatz_longest(1..~d)~%" n)
      (format t "n*=~d~%" nstar)
      (format t "steps=~d~%" steps)
      (format t "peak=~d~%" peak)
      (format t "xor_steps=~d~%" checksum))))

;; Run the main function
(main)
