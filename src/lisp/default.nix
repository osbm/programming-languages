{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "lisp";
  src = ./main.lisp;
  unpackPhase = "true";
  buildInputs = [pkgs.sbcl];
  buildPhase = ''
    cp $src main.lisp
    sbcl --script main.lisp > output.txt 2>&1 || true
    sbcl --eval "(compile-file \"main.lisp\")" --eval "(sb-ext:exit)"
    sbcl --eval "(load \"main.fasl\")" --eval "(sb-ext:exit)" > expected_output.txt 2>&1 || true
  '';
  installPhase = ''
    mkdir -p $out/bin

    # Create a script that runs the Lisp program
    cat > $out/bin/main << 'EOF'
#!/bin/sh
exec ${pkgs.sbcl}/bin/sbcl --script ${./main.lisp}
EOF
    chmod +x $out/bin/main
  '';
  meta.mainProgram = "main";
}
