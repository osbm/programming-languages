{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "c";
  src = ./main.c;
  unpackPhase = "true";
  buildPhase = ''
    gcc -o main $src
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
