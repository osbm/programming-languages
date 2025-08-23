{pkgs, ...}: pkgs.writers.writePyPy3Bin "pypy" {} (builtins.readFile ../python/main.py)
