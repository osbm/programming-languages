{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "cython";
  src = ./main.pyx;
  unpackPhase = "true";
  buildInputs = [
    (pkgs.python3.withPackages (ps: [ps.cython]))
    pkgs.gcc
  ];
  buildPhase = ''
    cp $src main.pyx
    ${pkgs.python3.withPackages (ps: [ps.cython])}/bin/python -m cython -3 --embed -o main.c main.pyx
    gcc -O3 -I${pkgs.python3}/include/python${pkgs.python3.pythonVersion} -o main main.c -L${pkgs.python3}/lib -lpython${pkgs.python3.pythonVersion}
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}