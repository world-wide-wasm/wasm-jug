#!/bin/bash
clear
bat $0 --line-range 5:
echo ""
# Build with Go
# GOOS=js GOARCH=wasm go build -o main.wasm
tinygo build -o main.wasm -target wasm ./main.go

ls -lh *.wasm
