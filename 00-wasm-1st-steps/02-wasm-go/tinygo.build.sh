#!/bin/bash
tinygo build -scheduler=none --no-debug \
  -o main.wasm \
  -target wasm main.go

ls -lh *.wasm

# -target wasi main.go