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
    dockerImages = forAllSystems (
      system: let
        pkgs = makePkgs system;
        allPackages = pkgs.callPackage ./src {};
        compatiblePackages = pkgs.lib.filterAttrs (name: value:
          pkgs.lib.isDerivation value &&
          builtins.elem system (value.meta.platforms or supportedSystems)
        ) allPackages;
      in
        pkgs.lib.mapAttrs (name: package:
          pkgs.dockerTools.buildImage {
            name = "programming-languages-${name}";
            tag = "latest";
            config = {
              Cmd = [ "${package}/bin/${package.meta.mainProgram or name}" ];
              WorkingDir = "/";
              Env = [
                "PATH=${pkgs.coreutils}/bin:${pkgs.bash}/bin"
              ];
            };
          }
        ) compatiblePackages
    );
  };
}
