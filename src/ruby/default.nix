{pkgs, ...}: pkgs.writers.writeRubyBin "ruby" {} (builtins.readFile ./main.rb)
