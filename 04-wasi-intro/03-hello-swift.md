# 03-hello-swift

```bash
swiftc -target wasm32-unknown-wasi hello.swift -o hello.wasm
ls -lh *.wasm
```

## Run

```bash
wasmtime hello.wasm
wasmer hello.wasm
wasmedge hello.wasm
wazero run hello.wasm
```