---
marp: true
---
# WASI Introduction

## WebAssembly (Wasm), outside the browser with Wasi

---
# Agenda

- Wasi
- Demos

---
# Wasm qualities

- Speed 
- Efficiency 
- Safe
- Versatile 
- Portable

---
# Free WASM from the browser

## Let it Go!

---
# WASI?

## WebAssembly System Interface

- WebAssembly System Interface
- Interface between 
  - WebAssembly (WASM) code 
  - And a Runtime environment
- Allowing WASM code to be run in various contexts
---
# Some WASI Use Cases

- CLI applications
- Applications with plug-ins (Zellij, Lapce)
- Database UDF (ScyllaDB, PostgreSQL)
- WebHooks, Filters, … (Webhook Relay, Envoy)
- FaaS (Fermyon cloud, WasmCloud, Shopify, …)
- …
---
# At least, 3 ways to run Wasm programs outside the browser

- WASI Runtimes CLI
- WASI Runtimes SDK
- Ready to use applications with embedded Wasm runtime
  - Spin from Fermyon
  - Wasm Workers Server from Wasm Lab
  - …
---
# WASI Runtimes

- WasmEdge, 
- Wasmtime, 
- Wasmer, 
- Wazero 🩵, 
- NodeJS, 
- … 
---
# Some Demos

---
# Next

## Wazero discovery
- Make your own CLI
- Call a function (not always simple)



