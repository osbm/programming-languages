{pkgs, ...}:
pkgs.writeShellScriptBin "octave" ''
  ${pkgs.octave}/bin/octave --no-gui --no-window-system --quiet ${./main.m}
''
