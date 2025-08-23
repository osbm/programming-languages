{ pkgs }:
pkgs.writeShellScriptBin "prolog" ''
  ${pkgs.swi-prolog}/bin/swipl -q -g main ${./main.pl}
''
