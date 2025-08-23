{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "java";
  src = ./Main.java;
  unpackPhase = "true";
  nativeBuildInputs = [pkgs.jdk];
  buildPhase = ''
    cp $src Main.java
    javac Main.java
    echo '#!/bin/bash' > main
    echo 'exec ${pkgs.jdk}/bin/java -cp $(dirname $0) Main "$@"' >> main
    chmod +x main
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp Main.class $out/bin/
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
