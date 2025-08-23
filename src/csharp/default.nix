{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "csharp";
  src = ./.;
  buildInputs = [ pkgs.dotnet-sdk ];
  buildPhase = ''
    dotnet new console --force --name CollatzApp
    cp Program.cs CollatzApp/Program.cs
    cd CollatzApp
    dotnet build -c Release
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp bin/Release/net*/CollatzApp.dll $out/bin/
    cp bin/Release/net*/CollatzApp.runtimeconfig.json $out/bin/
    cat > $out/bin/csharp << EOF
#!/bin/sh
exec ${pkgs.dotnet-runtime}/bin/dotnet $out/bin/CollatzApp.dll
EOF
    chmod +x $out/bin/csharp
  '';
  meta.mainProgram = "csharp";
}
