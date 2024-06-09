#!/bin/bash

GITLAB_WASM_TOKEN=glpat-rZxfVQSStAz-VFUhvxJx
GITLAB_WASM_PROJECT_ID=43900010

set -o allexport; source .publish; set +o allexport

echo "📦 ${WASM_PACKAGE}"
echo "📝 ${WASM_MODULE} ${WASM_VERSION}"

curl --header "PRIVATE-TOKEN: ${GITLAB_WASM_TOKEN}" \
     --upload-file ${WASM_FILE} \
     "https://gitlab.com/api/v4/projects/${GITLAB_WASM_PROJECT_ID}/packages/generic/${WASM_PACKAGE}/${WASM_VERSION}/${WASM_MODULE}"

echo ""
echo "🌍 https://gitlab.com/bots-garden/wasm-registry/-/packages"


#PUT /projects/:id/packages/generic/:package_name/:package_version/:file_name?status=:status

