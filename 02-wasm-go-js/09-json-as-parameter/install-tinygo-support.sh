#!/bin/bash
rm wasm_exec.js
cp "$(tinygo env TINYGOROOT)/targets/wasm_exec.js" .
