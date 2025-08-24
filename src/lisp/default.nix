{pkgs, ...}:
pkgs.writeShellScriptBin "lisp" ''
  ${pkgs.sbcl}/bin/sbcl --script ${./main.lisp}
''