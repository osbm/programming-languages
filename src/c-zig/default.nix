{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "c-zig";
  src = ./.;
  buildInputs = [pkgs.zig];
  buildPhase = ''
    export ZIG_GLOBAL_CACHE_DIR=$TMPDIR/zig-cache
    mkdir -p $ZIG_GLOBAL_CACHE_DIR
    zig build-exe main.zig collatz.c -lc -OReleaseFast --cache-dir $TMPDIR/zig-cache -I.
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}