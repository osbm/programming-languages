{ pkgs }:
pkgs.writeShellScriptBin "erlang" ''
  TMPDIR=$(mktemp -d)
  cp ${./main.erl} $TMPDIR/main.erl
  cd $TMPDIR
  ${pkgs.erlang}/bin/erlc main.erl
  ${pkgs.erlang}/bin/erl -noshell -s main main -s init stop
''
