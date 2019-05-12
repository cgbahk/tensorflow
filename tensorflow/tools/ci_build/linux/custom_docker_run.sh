#!/usr/bin/env bash
#
# Build tensorflow dev docker

set -ex
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/custom_config.sh"

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
  "$@"
