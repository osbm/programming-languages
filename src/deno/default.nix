{pkgs, ...}:
pkgs.writeShellScriptBin "deno" ''
  ${pkgs.deno}/bin/deno run --allow-read ${../nodejs/main.js}
''
