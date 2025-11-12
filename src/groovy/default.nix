{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "groovy";
  src = ./main.groovy;
  unpackPhase = "true";
  nativeBuildInputs = [pkgs.groovy];
  buildPhase = ''
    cp $src main.groovy
    echo '#!/bin/bash' > main
    echo 'exec ${pkgs.groovy}/bin/groovy $(dirname $0)/main.groovy "$@"' >> main
    chmod +x main
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main.groovy $out/bin/
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}