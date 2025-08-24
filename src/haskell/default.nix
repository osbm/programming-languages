{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "haskell";
  src = ./main.hs;
  unpackPhase = "true";
  buildInputs = [pkgs.ghc];
  buildPhase = ''
    ghc -o main $src
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
