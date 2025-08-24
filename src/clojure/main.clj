(defn collatz-len-and-peak [x]
  (loop [n x
         steps 0
         peak x]
    (if (= n 1)
      [steps peak]
      (let [next-n (if (odd? n)
                     (+ (* 3 n) 1)
                     (bit-shift-right n 1))
            new-peak (max peak next-n)]
        (recur next-n (inc steps) new-peak)))))

(defn scan-upto [n]
  (loop [i 1
         best-n 1
         best-steps 0
         best-peak 1
         xor-steps 0]
    (if (> i n)
      [best-n best-steps best-peak xor-steps]
      (let [[steps peak] (collatz-len-and-peak i)
            new-xor-steps (bit-xor xor-steps steps)
            [new-best-n new-best-steps new-best-peak]
            (if (> steps best-steps)
              [i steps peak]
              [best-n best-steps best-peak])]
        (recur (inc i) new-best-n new-best-steps new-best-peak new-xor-steps)))))

(defn -main []
  (println "hello world!")

  (let [n 1000000
        [best-n best-steps best-peak xor-steps] (scan-upto n)]
    (println (str "collatz_longest(1.." n ")"))
    (println (str "n*=" best-n))
    (println (str "steps=" best-steps))
    (println (str "peak=" best-peak))
    (println (str "xor_steps=" xor-steps)))

  (System/exit 0))

(-main)
