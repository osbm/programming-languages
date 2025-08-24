{ pkgs }:
pkgs.writeShellScriptBin "scheme" ''
  ${pkgs.guile}/bin/guile --no-auto-compile ${./main.scm}
''
