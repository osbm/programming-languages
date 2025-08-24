{ pkgs }:
pkgs.writeShellScriptBin "vlang" ''
  TMPDIR=$(mktemp -d)
  cp ${./main.v} $TMPDIR/main.v
  cd $TMPDIR
  export HOME=$TMPDIR
  ${pkgs.vlang}/bin/v run main.v
''
