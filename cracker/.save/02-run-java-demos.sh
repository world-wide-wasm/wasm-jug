#!/bin/bash
set -o allexport; source .env; set +o allexport

pkill -f extism-

GITLAB_WASM_PROJECT_ID="43900010"

#? Start 3 function runners with 3 different HTTP port
#LD_LIBRARY_PATH="/usr/local/lib"

# ----- GoLang function -----
WASM_PACKAGE="go_wasm_io"
WASM_VERSION="0.0.1"
WASM_MODULE="hello-go.wasm"

WASM_FILE="./tmp/hello-go.wasm" \
HTTP_PORT="8888" \
FUNCTION_NAME="helloWorld" \
WASM_REGISTRY="gitlab.com" \
WASM_URI="/api/v4/projects/${GITLAB_WASM_PROJECT_ID}/packages/generic/${WASM_PACKAGE}/${WASM_VERSION}/${WASM_MODULE}" \
bash -c \
"exec -a extism-helloWorld-8888 java -jar target/cracker-${CRACKER_VERSION}-SNAPSHOT-fat.jar &"

# ----- RustLang function -----
WASM_PACKAGE="rust_wasm_io"
WASM_VERSION="0.0.1"
WASM_MODULE="hello-rust.wasm"

WASM_FILE="./tmp/hello-rust.wasm" \
HTTP_PORT="9999" \
FUNCTION_NAME="hello_world" \
WASM_REGISTRY="gitlab.com" \
WASM_URI="/api/v4/projects/${GITLAB_WASM_PROJECT_ID}/packages/generic/${WASM_PACKAGE}/${WASM_VERSION}/${WASM_MODULE}" \
bash -c \
"exec -a extism-hello_world-9999 java -jar target/cracker-${CRACKER_VERSION}-SNAPSHOT-fat.jar &"

# ----- JavaScript function -----
WASM_PACKAGE="js_wasm_io"
WASM_VERSION="0.0.1"
WASM_MODULE="hello-js.wasm"

WASM_FILE="./tmp/hello-js.wasm" \
HTTP_PORT="6666" \
FUNCTION_NAME="helloJSWorld" \
WASM_REGISTRY="gitlab.com" \
WASM_URI="/api/v4/projects/${GITLAB_WASM_PROJECT_ID}/packages/generic/${WASM_PACKAGE}/${WASM_VERSION}/${WASM_MODULE}" \
bash -c \
"exec -a extism-helloJSWorld-6666 java -jar target/cracker-${CRACKER_VERSION}-SNAPSHOT-fat.jar &"

# ----- ZigLang function -----
WASM_PACKAGE="zig_wasm_io"
WASM_VERSION="0.0.1"
WASM_MODULE="HelloZig.wasm"

WASM_FILE="./tmp/HelloZig.wasm" \
HTTP_PORT="7777" \
FUNCTION_NAME="hello_world" \
WASM_REGISTRY="gitlab.com" \
WASM_URI="/api/v4/projects/${GITLAB_WASM_PROJECT_ID}/packages/generic/${WASM_PACKAGE}/${WASM_VERSION}/${WASM_MODULE}" \
bash -c \
"exec -a extism-hello_world-7777 java -jar target/cracker-${CRACKER_VERSION}-SNAPSHOT-fat.jar &"
