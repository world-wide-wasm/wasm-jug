---
marp: true
---
# WASM Part 4

## WebAssembly (Wasm) and Rust in the browser 🌍

---
# Agenda

- Rust + Wasm + Browser & demos
- Rust + Wasm + NodeJS 😲 & demo

---
# Rust to WebAssembly ?

## Wasm-Pack

- Building: https://rustwasm.github.io/docs/wasm-pack/

## Wasm-Bindgen (all the plumbing)

- Rust <=> JS, Rust library + CLI tool: https://rustwasm.github.io/wasm-bindgen/

---
# New project

> create the project
```bash
cargo new --lib hello-proj --name hello
cd hello-proj
cargo add wasm-bindgen
```

> update the Cargo.toml
```toml
[lib]
name = "hello"
path = "src/lib.rs"
crate-type =["cdylib"]

```
---
# Generated project

```bash
.
├── Cargo.toml
├── src
│  └── lib.rs
```

---
# Function code

```rust
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn hello(name: String) -> String {
  let message = String::from("👋 hello ");
  
  return message + &name;
}
```
---
# Build

```bash
wasm-pack build --release --target web
```
> 👋 `--target web`

---
# Generated package

```bash
pkg
├── hello.d.ts
├── hello.js  # have a 👀 to the file
├── hello_bg.wasm
└── hello_bg.wasm.d.ts
```

---
# Use `pkg` into an HTML page

```html
<script type="module">
  import init, { hello } from './pkg/hello.js'

  async function run() {
    await init()
    console.log(hello("Bob Morane")) 
  }
  run();
</script>
```
---
# Demos

- `01-hello`
- `02-hello-json`
- `03-hello-dom`

---
# Rust + Wasm + NodeJS

```bash
wasm-pack build --release --target nodejs 👋
```

```javascript
const pkg = require('./pkg/hello.js')
const {hello} = pkg
```

---
# Demos

- `04-hello-node`

---
# Next

## Introduction to WASI

---