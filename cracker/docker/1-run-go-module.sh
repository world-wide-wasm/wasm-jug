#!/bin/bash
set -o allexport; source .env; set +o allexport

read -r -d '' go_module_config << EOM
WASM_FILE=./tmp/hello-go.wasm
HTTP_PORT=8080
FUNCTION_NAME=helloWorld
WASM_REGISTRY=gitlab.com
GITLAB_WASM_PROJECT_ID=43900010
WASM_URI=/api/v4/projects/43900010/packages/generic/go_wasm_io/0.0.1/hello-go.wasm
EOM

printf "${go_module_config}" >> .go.config

docker run -p 8080:8080 --env-file=.go.config --rm ${IMAGE_NAME} 

#docker run -p 8080:8080 --env-file=.go.config --rm ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG}
