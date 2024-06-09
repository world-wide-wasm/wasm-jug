#!/bin/bash
set -o allexport; source .env; set +o allexport
echo "🐋 ${IMAGE_NAME}:${IMAGE_TAG}"

cp ../target/cracker-${CRACKER_VERSION}-SNAPSHOT-fat.jar ./

docker login -u ${DOCKER_USER} -p ${DOCKER_PWD}
docker build -t ${IMAGE_NAME} .

docker images | grep ${IMAGE_NAME}
