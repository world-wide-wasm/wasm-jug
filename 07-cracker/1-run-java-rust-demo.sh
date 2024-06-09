#!/bin/bash
set -o allexport; source .env; set +o allexport

# -------------------------------
#  RustLang function 
# -------------------------------
WASM_FILE="./tmp/hello_rust.wasm" \
HTTP_PORT="9999" \
FUNCTION_NAME="hello_world" \
java -jar target/cracker-${CRACKER_VERSION}-SNAPSHOT-fat.jar
