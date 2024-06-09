#!/bin/bash
set -o allexport; source .env; set +o allexport

pkill -f extism-

#LD_LIBRARY_PATH="/usr/local/lib"

WASM_FILE="./tmp/hello-go.wasm" \
HTTP_PORT="8888" \
FUNCTION_NAME="helloWorld" \
java -jar target/cracker-"${CRACKER_VERSION}"-SNAPSHOT-fat.jar


