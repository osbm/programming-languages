{pkgs, lib, ...}:
let 
  script = pkgs.writers.makeScriptWriter {
    interpreter = lib.getExe pkgs.python3;
  } "python" (builtins.readFile ./main.py);
in
  pkgs.writeScriptBin "python" (builtins.readFile script)
