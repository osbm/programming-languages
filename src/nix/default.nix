{pkgs, ...}:
pkgs.writeShellScriptBin "nix" ''
  ${pkgs.nix}/bin/nix eval --raw --option max-call-depth 1000000 -f ${./main.nix}
''
