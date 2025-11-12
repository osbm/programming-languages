{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "pascal";
  src = ./main.pas;
  unpackPhase = "true";
  nativeBuildInputs = [pkgs.fpc];
  buildPhase = ''
    cp $src main.pas
    fpc -O2 main.pas
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}