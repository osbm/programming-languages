{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "crystal";
  src = ./.;
  buildInputs = [pkgs.crystal];
  buildPhase = ''
    crystal build -o main ${./main.cr}
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
