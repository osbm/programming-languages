{pkgs, ...}:
pkgs.writeShellScriptBin "main" ''
  exec ${pkgs.php}/bin/php ${./main.php}
''
