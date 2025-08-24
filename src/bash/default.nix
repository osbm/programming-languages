{ pkgs }:
pkgs.writeShellScriptBin "bash" ''
  ${pkgs.bash}/bin/bash ${./main.sh}
''
