{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "go";
  src = ./main.go;
  unpackPhase = "true";
  buildInputs = [pkgs.go];
  buildPhase = ''
    GOCACHE=/build/cache go build -o main $src
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
