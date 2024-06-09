#!/bin/bash
clear
bat $0 --line-range 5:
echo ""
tinygo build -scheduler=none --no-debug \
  -o main.wasm \
  -target wasm main.go

ls -lh *.wasm
