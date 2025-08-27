{pkgs}:
pkgs.writeShellScriptBin "julia" ''
  ${pkgs.julia}/bin/julia ${./main.jl}
''
