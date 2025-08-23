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
    makePkgs = system: import nixpkgs {inherit system;};
  in {
    packages = forAllSystems (
      system: let
        pkgs = makePkgs system;
        allPackages = pkgs.callPackage ./src {};
      in
        # Filter out override functions that confuse nix flake show
        pkgs.lib.filterAttrs (name: value: pkgs.lib.isDerivation value) allPackages
    );
  };
}
