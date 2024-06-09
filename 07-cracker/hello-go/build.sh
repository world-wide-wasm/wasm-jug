#!/bin/bash
tinygo build -scheduler=none --no-debug -o hello-go.wasm -target wasi main.go
ls -lh *.wasm
