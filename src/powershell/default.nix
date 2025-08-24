{ pkgs }:
pkgs.writeShellScriptBin "powershell" ''
  ${pkgs.powershell}/bin/pwsh -File ${./main.ps1}
''
