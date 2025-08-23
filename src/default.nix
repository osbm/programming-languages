{
  pkgs,
  lib,
  ...
}: let
  all_files_in_this_directory = builtins.readDir ./.;

  all_files_except_default =
    lib.filterAttrs (
      filename: kind: filename != "default.nix" && (kind == "regular" || kind == "directory")
    )
    all_files_in_this_directory;
in
  lib.mapAttrs (filename: _: pkgs.callPackage ./${filename} {}) all_files_except_default
