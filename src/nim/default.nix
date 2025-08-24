{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "nim";
  src = ./main.nim;
  unpackPhase = "true";
  buildInputs = [pkgs.nim];
  buildPhase = ''
    cp $src main.nim
    export HOME=/tmp
    nim compile --verbosity:0 -o:main main.nim
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
