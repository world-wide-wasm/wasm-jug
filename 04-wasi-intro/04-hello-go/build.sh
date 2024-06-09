#!/bin/bash
clear
bat $0 --line-range 5:
echo ""
tinygo build -o main.wasm -target wasi ./main.go

ls -lh *.wasm