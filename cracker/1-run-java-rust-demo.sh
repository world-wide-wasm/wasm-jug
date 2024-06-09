#!/bin/bash
set -o allexport; source .env; set +o allexport

GITLAB_WASM_PROJECT_ID="43900010"

# ? Start 4 runner instances
# ? Every runner is loading a wasm module from a GitLab registry

# -------------------------------
#  RustLang function 
# -------------------------------
WASM_PACKAGE="rust_wasm_io"
WASM_VERSION="0.0.2"
WASM_MODULE="hello-rust.wasm"

WASM_FILE="./tmp/hello-rust.wasm" \
HTTP_PORT="9999" \
FUNCTION_NAME="hello_world" \
WASM_REGISTRY="gitlab.com" \
WASM_URI="/api/v4/projects/${GITLAB_WASM_PROJECT_ID}/packages/generic/${WASM_PACKAGE}/${WASM_VERSION}/${WASM_MODULE}" \
java -jar target/cracker-${CRACKER_VERSION}-SNAPSHOT-fat.jar &
