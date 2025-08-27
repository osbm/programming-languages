{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "assembly";
  src = ./.;
  buildInputs = [pkgs.gcc];
  buildPhase = ''
    gcc -o main main.s
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/
  '';
  meta = {
    mainProgram = "main";
    platforms = ["x86_64-linux"];
  };
}
