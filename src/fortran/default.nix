{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "fortran";
  src = ./.;
  nativeBuildInputs = [ pkgs.gfortran ];

  buildPhase = ''
    gfortran -o main ${./main.f90}
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/fortran
  '';
}
