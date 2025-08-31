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

## 🐳 Docker Usage

You can also build and run the examples as Docker images:

```bash
# Build a Docker image for C++ on x86_64-linux
nix build .#dockerImages.x86_64-linux.cpp

# Load the image into Docker
docker load < result

# Run the Docker container
docker run --rm programming-languages-cpp
```

Available Docker images for each supported architecture:
- `x86_64-linux` - Intel/AMD 64-bit Linux
- `aarch64-linux` - ARM 64-bit Linux
- `x86_64-darwin` - Intel/AMD 64-bit macOS
- `aarch64-darwin` - ARM 64-bit macOS (Apple Silicon)

**Note:** CUDA does not work idk why...


## 📊 What Each Program Does

1. **Prints "hello world!"**
2. **Computes Collatz sequences** for numbers 1 to 1,000,000
3. **Finds the longest sequence** and reports:
   - `n*` - The starting number with the longest sequence
   - `steps` - Number of steps in that sequence
   - `peak` - Highest value reached during computation
   - `xor_steps` - XOR checksum of all step counts

## 🎨 Implemented Languages

- ✅ **Assembly** - Low-level programming
- ✅ **Bash** - Shell scripting
- ✅ **Bun** - Fast JavaScript runtime
- ✅ **C** - Classic systems programming
- ✅ **C (assembly)** - C with partial assembly implementation (contributed by [bdrtr](https://github.com/bdrtr))
- ✅ **C++** - Object-oriented systems programming
- ✅ **C#** - .NET object-oriented programming
- ✅ **Clojure** - Lisp dialect for JVM
- ✅ **Crystal** - Ruby-like syntax, C-like performance
- ✅ **Cuda** - GPU programming
- ✅ **Cython** - Python with C extensions
- ✅ **D** - Systems programming with garbage collection
- ✅ **Dart** - Client-optimized programming
- ✅ **Deno** - Modern JavaScript/TypeScript runtime
- ✅ **Elixir** - Concurrent functional programming
- ✅ **Erlang** - Fault-tolerant concurrent programming
- ✅ **F#** - .NET functional-first language
- ✅ **Fish** - Friendly shell scripting
- ✅ **Fortran** - Scientific and numerical computing
- ✅ **Gleam** - Type-safe for Erlang VM
- ✅ **GLSL** - Graphics shader language
- ✅ **Go** - Concurrent systems programming
- ✅ **Go (concurrency)** - Go but with concurrency  (contributed by [bdrtr](https://github.com/bdrtr))
- ✅ **Haskell** - Pure functional programming
- ✅ **Java** - Enterprise object-oriented programming
- ✅ **JavaScript (Node.js)** - Web and server scripting
- ✅ **Julia** - High-performance scientific computing
- ✅ **Kotlin** - Modern JVM language
- ✅ **Lisp** - Classic functional programming
- ✅ **Lua** - Lightweight scripting
- ✅ **Nim** - Efficient, expressive systems programming
- ✅ **Nix** - Functional package management language
- ✅ **Nushell** - Modern shell with a focus on data
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
- ✅ **TypeScript** - Typed JavaScript
- ✅ **V** - Simple, fast compilation
- ✅ **Zig** - Simple, fast systems programming


## 🎯 Remaining Languages

- 🔄 **Bend** - Parallel programming language


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
