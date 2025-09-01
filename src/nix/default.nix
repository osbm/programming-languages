{pkgs, ...}:
let
  nixpkgs = pkgs.fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "nixpkgs-unstable";
    hash = "sha256-mBecwgUTWRgClJYqcF+y4O1bY8PQHqeDpB+zsAn+/zA=";
  };
in
pkgs.writeShellScriptBin "nix" ''
  ${pkgs.nix}/bin/nix eval --raw -I nixpkgs=${nixpkgs} --option max-call-depth 1000000 -f ${./main.nix}
''
