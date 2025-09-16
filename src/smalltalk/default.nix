{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "smalltalk";
  src = ./main.st;
  unpackPhase = "true";
  nativeBuildInputs = [pkgs.gnu-smalltalk];
  buildPhase = ''
    cp $src main.st
    echo '#!/bin/bash' > main
    echo 'exec ${pkgs.gnu-smalltalk}/bin/gst $(dirname $0)/main.st "$@"' >> main
    chmod +x main
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main.st $out/bin/
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}