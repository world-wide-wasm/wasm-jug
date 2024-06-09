#!/bin/bash
set -o allexport; source .env; set +o allexport

GITLAB_WASM_PROJECT_ID="43900010"

# ? Start 4 runner instances
# ? Every runner is loading a wasm module from a GitLab registry

# -------------------------------
#  GoLang function
# -------------------------------
WASM_PACKAGE="go_wasm_io"
WASM_VERSION="0.0.2"
WASM_MODULE="hello-go.wasm"

WASM_FILE="./tmp/hello-go.wasm" \
HTTP_PORT="8888" \
FUNCTION_NAME="helloWorld" \
WASM_REGISTRY="gitlab.com" \
WASM_URI="/api/v4/projects/${GITLAB_WASM_PROJECT_ID}/packages/generic/${WASM_PACKAGE}/${WASM_VERSION}/${WASM_MODULE}" \
java -jar target/cracker-${CRACKER_VERSION}-SNAPSHOT-fat.jar

