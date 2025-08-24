{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "d";
  src = ./main.d;
  unpackPhase = "true";
  buildInputs = [pkgs.dmd];
  buildPhase = ''
    cp $src main.d
    dmd -of=main main.d
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
