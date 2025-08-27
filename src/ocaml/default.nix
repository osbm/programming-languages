{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "ocaml";
  src = ./.;
  buildInputs = [pkgs.ocaml];
  buildPhase = ''
    ocamlc -o main ${./main.ml}
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
