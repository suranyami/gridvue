#!/bin/sh
set -ex
docker build -t "${IMAGE_REPOSITORY}:${IMAGE_NAME}" .
docker push "${IMAGE_REPOSITORY}:${IMAGE_NAME}"
