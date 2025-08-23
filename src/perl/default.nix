{pkgs, ...}:
pkgs.writers.writePerlBin "perl" {} (builtins.readFile ./main.pl)
