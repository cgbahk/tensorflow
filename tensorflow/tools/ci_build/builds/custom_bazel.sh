#!/usr/bin/env bash
#
# Mock bazel command
#  Usage) __/custom_bazel.sh test|build target
#  Example) __/custom_bazel.sh test //tensorflow/contrib/lite:interpreter_test
#
# TODO Script to build or test custom target
# Currently just do fixed target: test TFlite interpreter. This script assumed
# to executed in TF dev docker image on tensorflow root directory

set -x

# Sanity check that this is being run from the root of the git repository.
if [ ! -e "WORKSPACE" ]; then
  echo "Must run this from the root of the bazel workspace"
  exit 1
fi

BAZEL_OPTS="-c opt --cxxopt=-D_GLIBCXX_USE_CXX11_ABI=0"
export CC_OPT_FLAGS='-mavx'
if [ "${TF_NEED_CUDA}" == "1" ]; then
  BAZEL_OPTS="${BAZEL_OPTS} --config=cuda"
fi
yes "" | ./configure

BAZEL_CMD=$1 && shift
BAZEL_TARGETS=$*
bazel ${BAZEL_CMD} ${BAZEL_OPTS} ${BAZEL_TARGETS}

# Delete any leftovers from previous builds in this workspace.
#DIR=artifacts
#rm -rf ${DIR}
#mkdir -p ${DIR}

# Sample code to copy artifacts
#cp bazel-bin/tensorflow/__ ${DIR}/__
#chmod -x ${DIR}/*
