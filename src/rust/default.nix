{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "rust";
  src = ./main.rs;
  unpackPhase = "true";
  buildInputs = [pkgs.rustc];
  buildPhase = ''
    rustc -o main $src
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
