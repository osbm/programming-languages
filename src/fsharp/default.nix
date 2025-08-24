{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "fsharp";
  src = ./.;
  buildInputs = [pkgs.dotnet-sdk];
  buildPhase = ''
    dotnet new console -lang F# --force --name FSharpApp
    cp Program.fs FSharpApp/Program.fs
    cd FSharpApp
    dotnet build -c Release
  '';
  installPhase = ''
    mkdir -p $out/bin

    # Copy all the built files
    cp -r bin/Release/net*/* $out/bin/

    # Create wrapper script
    cat > $out/bin/main << EOF
#!/bin/sh
export DOTNET_ROOT=${pkgs.dotnet-runtime}
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
cd $out/bin
exec ${pkgs.dotnet-runtime}/bin/dotnet $out/bin/FSharpApp.dll "\$@"
EOF
    chmod +x $out/bin/main
  '';
  meta.mainProgram = "main";
}
