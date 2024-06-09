#!/bin/bash
set -o allexport; source .publish; set +o allexport

echo "📦 ${WASM_PACKAGE}"
echo "📝 ${WASM_MODULE} ${WASM_VERSION}"

curl "https://gitlab.com/api/v4/projects/${GITLAB_WASM_PROJECT_ID}/packages/generic/${WASM_PACKAGE}/${WASM_VERSION}/${WASM_MODULE}" \
     --output ${WASM_MODULE}
     
