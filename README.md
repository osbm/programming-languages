# 🚀 Programming Languages Collection

A comprehensive Nix flake that contains examples of different programming languages, all implementing the same algorithm for easy comparison.

## 🎯 Overview

Each example prints "hello world!" and performs a computation about the **Collatz Conjecture**. All implementations are kept as similar as possible to showcase language differences while maintaining algorithmic consistency.

## 🔧 Usage

You can build and run any language example using Nix:

```bash
# Build and run Python example
nix run github:osbm/programming-languages#python

# Or you can first build and then run to compare compilation and execution times
nix build github:osbm/programming-languages#rust
nix run github:osbm/programming-languages#rust
```


## 📊 What Each Program Does

1. **Prints "hello world!"**
2. **Computes Collatz sequences** for numbers 1 to 1,000,000
3. **Finds the longest sequence** and reports:
   - `n*` - The starting number with the longest sequence
   - `steps` - Number of steps in that sequence
   - `peak` - Highest value reached during computation
   - `xor_steps` - XOR checksum of all step counts

## 🎨 Implemented Languages

- ✅ **Bash** - Shell scripting
- ✅ **C** - Classic systems programming
- ✅ **C++** - Object-oriented systems programming
- ✅ **C#** - .NET object-oriented programming
- ✅ **Crystal** - Ruby-like syntax, C-like performance
- ✅ **Cython** - Python with C extensions
- ✅ **D** - Systems programming with garbage collection
- ✅ **Dart** - Client-optimized programming
- ✅ **Deno** - Modern JavaScript/TypeScript runtime
- ✅ **Elixir** - Concurrent functional programming
- ✅ **Erlang** - Fault-tolerant concurrent programming
- ✅ **F#** - .NET functional-first language
- ✅ **Fish** - Friendly shell scripting
- ✅ **Fortran** - Scientific and numerical computing
- ✅ **Go** - Concurrent systems programming
- ✅ **Java** - Enterprise object-oriented programming
- ✅ **JavaScript (Node.js)** - Web and server scripting
- ✅ **Julia** - High-performance scientific computing
- ✅ **Kotlin** - Modern JVM language
- ✅ **Lisp** - Classic functional programming
- ✅ **Lua** - Lightweight scripting
- ✅ **Nim** - Efficient, expressive systems programming
- ✅ **OCaml** - ML family functional language
- ✅ **Octave** - MATLAB-compatible mathematical programming
- ✅ **Perl** - Text processing and scripting
- ✅ **PHP** - Web development scripting
- ✅ **PowerShell** - Object-oriented shell
- ✅ **Prolog** - Logic programming
- ✅ **Python** - General-purpose scripting
- ✅ **PyPy** - High-performance Python implementation
- ✅ **R** - Statistical computing
- ✅ **Racket** - Modern Lisp/Scheme
- ✅ **Ruby** - Elegant scripting language
- ✅ **Rust** - Memory-safe systems programming
- ✅ **Scheme** - Minimalist Lisp dialect
- ✅ **Swift** - Apple's modern programming language
- ✅ **TypeScript** - Typed JavaScript
- ✅ **V** - Simple, fast compilation
- ✅ **Zig** - Simple, fast systems programming


## 🎯 Remaining Languages

- 🔄 **Haskell** - Pure functional programming
- 🔄 **Clojure** - Lisp dialect for JVM
- 🔄 **Bun** - Fast JavaScript runtime
- 🔄 **Assembly** - Low-level programming
- 🔄 **Carbon** - Google's C++ successor (experimental)
- 🔄 **Cuda** - GPU programming
- 🔄 **Gleam** - Type-safe for Erlang VM
- 🔄 **Mojo** - Python-compatible AI language
- 🔄 **Bend** - Parallel programming language
- 🔄 **Nix** - Functional package management language
- 🔄 **GLSL** - Graphics shader language


## 🏆 Example Output

All programs produce identical output (though some programs do not count all the way up to 1,000,000 due to performance constraints):

```
hello world!
collatz_longest(1..1000000)
n*=837799
steps=524
peak=2974984576
xor_steps=880
```

## 🛠️ Requirements

- **Nix** with flakes enabled
- **Internet access** (nix will take care of fetching dependencies)

## 📈 Contributing

Feel free to contribute new language implementations! Each language should:

1. Print "hello world!"
2. Implement the Collatz conjecture algorithm
3. Produce the exact same numerical output
4. Be buildable with Nix
5. Follow the existing project structure

## 📜 License

This project is open source and available under the MIT License.
