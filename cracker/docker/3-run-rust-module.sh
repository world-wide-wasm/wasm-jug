#!/bin/bash
set -o allexport; source .env; set +o allexport

read -r -d '' rust_module_config << EOM
WASM_FILE=./tmp/hello-rust.wasm
HTTP_PORT=8080
FUNCTION_NAME=hello_world
WASM_REGISTRY=gitlab.com
GITLAB_WASM_PROJECT_ID=43900010
WASM_URI=/api/v4/projects/43900010/packages/generic/rust_wasm_io/0.0.1/hello-rust.wasm
EOM

printf "${rust_module_config}" >> .rust.config

docker run -p 8888:8080 --env-file=.rust.config --rm ${IMAGE_NAME} 

#docker run -p 8888:8080 --env-file=.rust.config --rm ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG}
