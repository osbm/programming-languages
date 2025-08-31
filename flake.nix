{
  description = "A flake that contains some programming language examples";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    makePkgs = system:
      import nixpkgs {
        inherit system;
        config = {
          cudaSupport = true;
          allowUnfreePredicate = pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [
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
  in {
    packages = forAllSystems (
      system: let
        pkgs = makePkgs system;
        allPackages = pkgs.callPackage ./src {};
      in
        # Filter out override functions that confuse nix flake show
        # and filter out packages that don't support the current system
        pkgs.lib.filterAttrs (name: value: 
          pkgs.lib.isDerivation value && 
          builtins.elem system (value.meta.platforms or supportedSystems)
        ) allPackages
    );
  };
}
