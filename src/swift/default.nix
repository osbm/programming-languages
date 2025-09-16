{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "swift";
  src = ./main.swift;
  unpackPhase = "true";
  nativeBuildInputs = [pkgs.swift];
  buildPhase = ''
    cp $src main.swift
    swiftc -o main main.swift
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta = {
    mainProgram = "main";
    platforms = ["x86_64-linux" "aarch64-linux"];
  };
}