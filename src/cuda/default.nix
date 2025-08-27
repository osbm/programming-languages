{ pkgs, ... }:
let
  # Use CUDA 12.0 which should be compatible with driver 580.76.05
  cudaPackages = pkgs.cudaPackages_12_0;
  cudatoolkit = cudaPackages.cudatoolkit;
in
cudaPackages.backendStdenv.mkDerivation {
  name = "cuda";
  src = ./main.cu;
  unpackPhase = "true";
  buildInputs = [
    cudatoolkit
    cudaPackages.cuda_cudart
  ];
  nativeBuildInputs = [
    cudatoolkit
    pkgs.autoAddDriverRunpath
  ];
  LD_LIBRARY_PATH = "${cudatoolkit}/lib:${cudaPackages.cuda_cudart}/lib";
  buildPhase = ''
    echo "GCC Version:"
    gcc --version
    echo "NVCC Version:"
    nvcc --version

    echo "Building CUDA program..."
    nvcc -arch=sm_89 -o main $src
    mkdir -p $out/bin
    cp main $out/bin/
  '';
  meta = {
    mainProgram = "main";
    platforms = [ "x86_64-linux" ];
  };
}
