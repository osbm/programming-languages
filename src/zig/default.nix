{ pkgs ? import <nixpkgs> {} }:

pkgs.writeShellScriptBin "zig" ''
  cd ${./.}
  ${pkgs.zig}/bin/zig run main.zig
''
