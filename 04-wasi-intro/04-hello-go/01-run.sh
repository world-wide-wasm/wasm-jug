#!/bin/bash
clear
bat $0 --line-range 5:
echo ""
wasmedge main.wasm
