{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "cobol";
  src = ./main.cob;
  unpackPhase = "true";
  nativeBuildInputs = [pkgs.gnucobol];
  buildPhase = ''
    cp $src main.cob
    cobc -x -o main main.cob
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}