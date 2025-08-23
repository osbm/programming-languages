{pkgs, ...}:
pkgs.writers.writePython3Bin "python" {} (builtins.readFile ./main.py)
