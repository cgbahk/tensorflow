#!/usr/bin/env bash
#
# Run tensorflow dev docker to build & open terminal session to it

set -ex
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/custom_config.sh"

docker build \
  -t "${DOCKER_IMAGE}" \
  -f "${DOCKER_CONTEXT_PATH}/${DOCKER_FILE}" \
  "${DOCKER_CONTEXT_PATH}"
