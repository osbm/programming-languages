{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "zig";
  src = ./main.zig;
  unpackPhase = "true";
  buildInputs = [ pkgs.zig ];
  buildPhase = ''
    cp $src main.zig
    export ZIG_GLOBAL_CACHE_DIR=$TMPDIR/zig-cache
    mkdir -p $ZIG_GLOBAL_CACHE_DIR
    zig build-exe main.zig -OReleaseFast --cache-dir $TMPDIR/zig-cache
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
