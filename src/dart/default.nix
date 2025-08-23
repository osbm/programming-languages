{pkgs, ...}:
pkgs.writeShellScriptBin "main" ''
  exec ${pkgs.dart}/bin/dart ${./main.dart}
''
