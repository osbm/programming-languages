{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "kotlin";
  src = ./main.kt;
  unpackPhase = "true";
  nativeBuildInputs = [pkgs.kotlin pkgs.jdk];
  buildPhase = ''
    cp $src main.kt
    kotlinc main.kt -include-runtime -d main.jar
    echo '#!/bin/bash' > main
    echo 'exec ${pkgs.jdk}/bin/java -jar $(dirname $0)/main.jar "$@"' >> main
    chmod +x main
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main.jar $out/bin/
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
