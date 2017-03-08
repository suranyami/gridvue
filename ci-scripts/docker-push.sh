#!/bin/bash

set -ex

BRANCH_TAG="${BUILDKITE_BRANCH//\//_}"
docker pull "${IMAGE_REPOSITORY}:${IMAGE_NAME}"
docker tag "${IMAGE_REPOSITORY}:${IMAGE_NAME}" "${IMAGE_REPOSITORY}:${BRANCH_TAG}"
docker push "${IMAGE_REPOSITORY}:${BRANCH_TAG}"
