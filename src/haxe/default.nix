{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "haxe";
  src = ./Main.hx;
  unpackPhase = "true";
  nativeBuildInputs = [pkgs.haxe pkgs.neko];
  buildPhase = ''
    cp $src Main.hx
    haxe -main Main -neko main.n
    echo '#!/bin/bash' > main
    echo 'exec ${pkgs.neko}/bin/neko $(dirname $0)/main.n "$@"' >> main
    chmod +x main
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main.n $out/bin/
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}