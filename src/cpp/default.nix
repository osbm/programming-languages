{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "cpp";
  src = ./main.cpp;
  unpackPhase = "true";
  buildPhase = ''
    g++ -o main $src
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
