#!/bin/bash
clear
bat $0 --line-range 5:
echo ""
./wasm-server \
../03-go-plugin/go-plugin.wasm \
say_hello \
8081 &

./wasm-server \
../04-rust-plugin/target/wasm32-wasi/release/rust_plugin.wasm \
hello \
8082 &



