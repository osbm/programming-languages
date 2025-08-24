{pkgs, ...}:
pkgs.writeShellScriptBin "racket" ''
  ${pkgs.racket}/bin/racket ${./main.rkt}
''
