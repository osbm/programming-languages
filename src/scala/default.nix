{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "scala";
  src = ./Main.scala;
  unpackPhase = "true";
  nativeBuildInputs = [pkgs.scala];
  buildPhase = ''
    cp $src Main.scala
    scalac Main.scala
    echo '#!/bin/bash' > main
    echo 'exec ${pkgs.scala}/bin/scala -classpath $(dirname $0) Main "$@"' >> main
    chmod +x main
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp *.class $out/bin/
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}