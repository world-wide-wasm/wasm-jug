#!/bin/bash

set -o allexport; source .env; set +o allexport
echo "🐋 ${IMAGE_NAME}-amd64:${IMAGE_TAG}"
 
docker tag ${IMAGE_NAME}-amd64 ${DOCKER_USER}/${IMAGE_NAME}-amd64:${IMAGE_TAG}
docker push ${DOCKER_USER}/${IMAGE_NAME}-amd64:${IMAGE_TAG}
