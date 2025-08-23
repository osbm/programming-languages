{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "typescript";
  src = ./main.ts;
  unpackPhase = "true";
  buildInputs = [pkgs.nodejs pkgs.typescript];
  buildPhase = ''
    tsc --target es2020 --outFile main.js $src
    echo '#!/usr/bin/env node' > main
    cat main.js >> main
    chmod +x main
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}