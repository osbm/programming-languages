{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "nodejs";
  src = ./main.js;
  unpackPhase = "true";
  buildInputs = [pkgs.nodejs];
  buildPhase = ''
    echo '#!/usr/bin/env node' > main
    cat $src >> main
    chmod +x main
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
