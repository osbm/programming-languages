{pkgs}:
pkgs.writeShellScriptBin "fish" ''
  ${pkgs.fish}/bin/fish ${./main.fish}
''
