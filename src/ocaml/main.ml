let collatz_len_and_peak x =
  let rec loop n steps peak =
    if n = 1 then (steps, peak)
    else
      let new_n = if n land 1 = 1 then 3 * n + 1 else n lsr 1 in
      let new_peak = if new_n > peak then new_n else peak in
      loop new_n (steps + 1) new_peak
  in
  loop x 0 x

let scan_upto limit =
  let rec loop n best_n best_steps best_peak xor_steps =
    if n > limit then (best_n, best_steps, best_peak, xor_steps)
    else
      let (steps, peak) = collatz_len_and_peak n in
      let new_xor_steps = xor_steps lxor steps in
      let (new_best_n, new_best_steps, new_best_peak) =
        if steps > best_steps then (n, steps, peak)
        else (best_n, best_steps, best_peak)
      in
      loop (n + 1) new_best_n new_best_steps new_best_peak new_xor_steps
  in
  loop 1 1 0 1 0

let () =
  print_endline "hello world!";
  let n_limit = 1000000 in
  let (nstar, steps, peak, checksum) = scan_upto n_limit in
  Printf.printf "collatz_longest(1..%d)\n" n_limit;
  Printf.printf "n*=%d\n" nstar;
  Printf.printf "steps=%d\n" steps;
  Printf.printf "peak=%d\n" peak;
  Printf.printf "xor_steps=%d\n" checksum
