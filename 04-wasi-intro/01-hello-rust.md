# 01-hello-rust

> sources: 
> - https://surma.dev/things/rust-to-webassembly/
> - https://github.com/bytecodealliance/wasmtime/blob/main/docs/WASI-tutorial.md#from-rust
> - https://www.jakubkonka.com/2020/04/28/rust-wasi-from-scratch.html


```bash
cargo new 01-hello-rust --name hello

# the name `01-hello` cannot be used as a package name, the name cannot start with a digit
# If you need a package name to not match the directory name, consider using --name flag.
```

## Build

```bash
# if needed (already installed)
rustup target add wasm32-wasi
cd 01-hello-rust
cargo build --target wasm32-wasi
# target/wasm32-wasi/debug/hello.wasm
#cargo build --target=wasm32-wasi --release
```

## Run

```bash
wasmtime target/wasm32-wasi/debug/hello.wasm
wasmer target/wasm32-wasi/debug/hello.wasm
wasmedge target/wasm32-wasi/debug/hello.wasm
wazero run target/wasm32-wasi/debug/hello.wasm
```

## Change the source code

```rust
use std::io;

fn main() {
    println!("👋 hello, please type your name:");
    
    let mut user_input = String::new();
    let stdin = io::stdin();
    let _ = stdin.read_line(&mut user_input);

    println!("🤗 thank you {} ", user_input);
}
```
> Re-build and re-run

## Optim

```
en rust pour optimiser la taille du fichier wasm tu as les options de compilation opt-level = "z" lto = true
```