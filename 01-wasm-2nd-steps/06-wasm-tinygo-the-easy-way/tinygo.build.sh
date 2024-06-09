#!/bin/bash
clear
bat $0 --line-range 5:
echo ""
tinygo build --no-debug \
  -o main.wasm \
  -target wasm main.go

ls -lh *.wasm
