#!/bin/bash
set -o allexport; source .env; set +o allexport
echo "🐋 ${IMAGE_NAME}:${IMAGE_TAG}"

docker images | grep ${IMAGE_NAME}
