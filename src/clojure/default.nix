{ pkgs, ... }:

pkgs.writeShellScriptBin "clojure" ''
  ${pkgs.clojure}/bin/clojure -M ${./main.clj}
''
