{pkgs}:
pkgs.writeShellScriptBin "nushell" ''
  ${pkgs.nushell}/bin/nu ${./main.nu}
''
