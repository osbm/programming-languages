{ pkgs, ... }:

pkgs.writeShellScriptBin "bun" ''
  ${pkgs.bun}/bin/bun run ${../nodejs/main.js}
''
