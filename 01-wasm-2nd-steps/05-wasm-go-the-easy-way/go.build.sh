#!/bin/bash
clear
bat $0 --line-range 5:
echo ""
GOOS=js GOARCH=wasm go build -o main.wasm

ls -lh *.wasm
