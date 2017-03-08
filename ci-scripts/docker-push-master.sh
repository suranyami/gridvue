#!/bin/bash

set -ex

docker pull "${IMAGE_REPOSITORY}:${IMAGE_NAME}"
docker tag "${IMAGE_REPOSITORY}:${IMAGE_NAME}" "${IMAGE_REPOSITORY}:${BUILDKITE_COMMIT}"
docker push "${IMAGE_REPOSITORY}:${BUILDKITE_COMMIT}"
docker tag "${IMAGE_REPOSITORY}:${IMAGE_NAME}" "${IMAGE_REPOSITORY}:latest"
docker push "${IMAGE_REPOSITORY}:latest"
