#!/usr/bin/env bash
#
# configuration before docker build or run. SCRIPT_DIR should be ready

export TF_NEED_CUDA=0
export TF_NEED_ROCM=0
export BUILD_DOCKER_IMAGE=0

source "${SCRIPT_DIR}/../builds/builds_common.sh"
DOCKER_CONTEXT_PATH="$(realpath ${SCRIPT_DIR}/..)"
ROOT_DIR="$(realpath ${SCRIPT_DIR}/../../../../)"

DOCKER_IMAGE="tf-libtensorflow-cpu"
DOCKER_FILE="Dockerfile.cpu"
DOCKER_BINARY="docker"

