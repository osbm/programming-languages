{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "gleam";
  src = ./main.gleam;
  unpackPhase = "true";
  # just create a bash script that puts gleam.toml and main.gleam in the same directory and runs gleam but not during the build
  buildPhase = ''
    mkdir -p $out/bin
    echo '#!${pkgs.bash}/bin/bash' > $out/bin/gleam
    echo 'export PATH=${pkgs.erlang}/bin:${pkgs.gleam}/bin:$PATH' >> $out/bin/gleam
    echo 'temp_dir=$(mktemp -d)' >> $out/bin/gleam
    echo 'mkdir -p $temp_dir/src' >> $out/bin/gleam
    echo 'cp ${./main.gleam} $temp_dir/src/collatz.gleam' >> $out/bin/gleam
    echo 'cp ${./gleam.toml} $temp_dir/gleam.toml' >> $out/bin/gleam
    echo 'cd $temp_dir' >> $out/bin/gleam
    echo '${pkgs.gleam}/bin/gleam run' >> $out/bin/gleam
    chmod +x $out/bin/gleam
  '';
  installPhase = "true";
}
