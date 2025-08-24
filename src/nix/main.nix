# This Nix file returns our formatted string, similar to the Python implementation
let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) lib;

  collatzLenAndPeak = x:
    let
      collatz = n: steps: peak:
        if n == 1 then { steps = steps; peak = peak; }
  else if n - (n / 2) * 2 == 1 then collatz (3 * n + 1) (steps + 1) (lib.max peak (3 * n + 1))
        else collatz (n / 2) (steps + 1) (lib.max peak (n / 2));
    in collatz x 0 x;

  scanUpto = limit:
    let
      nums = lib.range 1 limit;
      results = lib.map (n:
        let r = collatzLenAndPeak n;
        in { n = n; steps = r.steps; peak = r.peak; }
      ) nums;
      best = lib.foldl' (a: b:
        if b.steps > a.steps then b else a
      ) { n = 1; steps = 0; peak = 1; } results;

  xor_steps = lib.foldl' (a: b: builtins.bitXor a b.steps) 0 results;
    in {
      nstar = best.n;
      steps = best.steps;
      peak = best.peak;
      xor_steps = xor_steps;
    };

  n_limit = 1000000; # 1000000 is very slow in Nix, use 1000 for demo
  stats = scanUpto n_limit;
  formatted = ''collatz_longest(1..${toString n_limit})
n*=${toString stats.nstar}
steps=${toString stats.steps}
peak=${toString stats.peak}
xor_steps=${toString stats.xor_steps}
'';
in
formatted
