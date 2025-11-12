{pkgs, ...}: let
  # Create a nixpkgs instance with CUDA support enabled
  pkgsWithCuda = import pkgs.path {
    inherit (pkgs) system;
    config = pkgs.config // {
      cudaSupport = true;
      allowUnfreePredicate = pkg:
            builtins.elem (pkgs.lib.getName pkg) [
              "cuda-merged"
              "cuda_cuobjdump"
              "cuda_gdb"
              "cuda_nvcc"
              "cuda_nvdisasm"
              "cuda_profiler"
              "cuda_nvprune"
              "cuda_cccl"
              "cuda_cudart"
              "cuda_cupti"
              "cuda_cuxxfilt"
              "cuda_nvml_dev"
              "cuda_nvrtc"
              "cuda_nvtx"
              "cuda_profiler_api"
              "cuda_sanitizer_api"
              "libcublas"
              "libcurand"
              "libcufft"
              "libcusolver"
              "libnvjitlink"
              "libcusparse"
              "libnpp"
              "nvidia-x11"
            ];
    };
  };

  # Use CUDA 12.0 which should be compatible with driver 580.76.05
  cudaPackages = pkgsWithCuda.cudaPackages;
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
      platforms = ["x86_64-linux"];
    };
  }
