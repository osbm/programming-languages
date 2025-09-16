{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "forth";
  src = ./main.forth;
  unpackPhase = "true";
  nativeBuildInputs = [pkgs.gforth];
  buildPhase = ''
    cp $src main.forth
    echo '#!/bin/bash' > main
    echo 'exec ${pkgs.gforth}/bin/gforth $(dirname $0)/main.forth "$@"' >> main
    chmod +x main
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main.forth $out/bin/
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}