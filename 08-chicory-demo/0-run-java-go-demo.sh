#!/bin/bash
set -o allexport; source .env; set +o allexport
# -------------------------------
#  GoLang function
# -------------------------------
WASM_FILE="./tmp/demo.wasm" \
HTTP_PORT="8888" \
FUNCTION_NAME="hello" \
java -jar target/cracker-${CRACKER_VERSION}-SNAPSHOT-fat.jar

