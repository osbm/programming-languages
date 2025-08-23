{pkgs, ...}: pkgs.writers.writeLuaBin "lua" {} (builtins.readFile ./main.lua)
