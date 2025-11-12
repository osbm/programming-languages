{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "awk";
  src = ./main.awk;
  unpackPhase = "true";
  nativeBuildInputs = [pkgs.gawk];
  buildPhase = ''
    cp $src main.awk
    chmod +x main.awk
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main.awk $out/bin/main
  '';
  meta.mainProgram = "main";
}