{pkgs, ...}:
pkgs.writeShellScriptBin "main" ''
  exec ${pkgs.R}/bin/Rscript ${./main.R}
''
