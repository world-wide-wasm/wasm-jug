#!/bin/bash
rm wasm_exec.js
cp "$(go env GOROOT)/misc/wasm/wasm_exec.js" .
