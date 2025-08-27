{ pkgs, ...}:

pkgs.stdenv.mkDerivation {
  name = "c-assembly";
  src = ./.;
  buildInputs = [ pkgs.gcc ];
  buildPhase = ''
    gcc -o main main.c collatz.S
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/
  '';
  meta = {
    mainProgram = "main";
    platforms = [ "x86_64-linux" ];
  };
}
