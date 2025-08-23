{ pkgs ? import <nixpkgs> {} }:

pkgs.writeShellScriptBin "elixir" ''
  cd ${./.}
  ${pkgs.elixir}/bin/elixir main.exs
''
