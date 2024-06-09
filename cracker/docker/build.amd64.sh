#!/bin/bash

set -o allexport; source .env; set +o allexport
echo "🐋 ${IMAGE_NAME}-amd64:${IMAGE_TAG}"

cp ../target/cracker-${CRACKER_VERSION}-SNAPSHOT-fat.jar ./

docker login -u ${DOCKER_USER} -p ${DOCKER_PWD}
docker buildx build --platform linux/amd64 -t ${IMAGE_NAME}-amd64 .

docker images | grep ${IMAGE_NAME}-amd64

# docker buildx ls
