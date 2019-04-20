#!/usr/bin/env bash
#
# Run tensorflow dev docker to build & open terminal session to it

set -ex
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export TF_NEED_CUDA=0
export TF_NEED_ROCM=0
export BUILD_DOCKER_IMAGE=0

source "${SCRIPT_DIR}/../builds/builds_common.sh"
ROOT_DIR="$(realpath ${SCRIPT_DIR}/../../../../)"

DOCKER_IMAGE="tf-libtensorflow-cpu"
DOCKER_BINARY="docker"

${DOCKER_BINARY} run \
  --rm -it \
  --pid=host \
  -v ${ROOT_DIR}:/workspace \
  -w /workspace \
  -e "PYTHON_BIN_PATH=/usr/bin/python" \
  -e "TF_NEED_HDFS=0" \
  -e "TF_NEED_CUDA=${TF_NEED_CUDA}" \
  -e "TF_NEED_TENSORRT=${TF_NEED_CUDA}" \
  -e "TF_NEED_ROCM=${TF_NEED_ROCM}" \
  -e "TF_NEED_OPENCL_SYCL=0" \
  "${DOCKER_IMAGE}" \
  bash
