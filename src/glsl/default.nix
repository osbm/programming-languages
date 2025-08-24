{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "glsl";
  src = ./.;
  unpackPhase = "true";
  buildInputs = with pkgs; [
    gcc
    glew
    glfw
    libGL
    libGLU
    xorg.libX11
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXi
  ];
  buildPhase = ''
    cp -r $src/* .
    g++ -o main main.cpp -lGLEW -lglfw -lGL -lGLU -lX11
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/main
  '';
  meta.mainProgram = "main";
}
