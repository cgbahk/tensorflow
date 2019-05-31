docker-build:
	tensorflow/tools/ci_build/linux/custom_docker_build.sh

docker-run:
	tensorflow/tools/ci_build/linux/custom_docker_run.sh bash

###############################################################################
# git
git:
	git checkout master
	git fetch upstream
	git merge upstream/master
	git push

###############################################################################
# tflite

test-tflite-interp:
	tensorflow/tools/ci_build/linux/custom_docker_run.sh \
	  bash -c \
	  "tensorflow/tools/ci_build/builds/custom_bazel.sh \
	  test //tensorflow/lite:interpreter_test"

tflite-tutorial:
    # Note: model should source 28x28 input, and make one hot data
	tensorflow/tools/ci_build/linux/custom_docker_run.sh \
	  bash -c \
	  "tensorflow/tools/ci_build/builds/custom_bazel.sh \
	  build //tensorflow/lite/tutorials:mnist_tflite; \
	  bazel-bin/tensorflow/lite/tutorials/mnist_tflite --model_file ${mnist-tflite-model-file}"


###############################################################################
# examples
test-regression:
	tensorflow/tools/ci_build/linux/custom_docker_run.sh \
	  bash -c \
	  "tensorflow/tools/ci_build/builds/custom_bazel.sh \
	  test //tensorflow/examples/get_started/regression:test"

###############################################################################
# toco

build-toco-binary:
	tensorflow/tools/ci_build/linux/custom_docker_run.sh \
	  bash -c \
	  "tensorflow/tools/ci_build/builds/custom_bazel.sh \
	  build //tensorflow/lite/toco:toco"

test-toco-tflite:
	tensorflow/tools/ci_build/linux/custom_docker_run.sh \
	  bash -c \
	  "tensorflow/tools/ci_build/builds/custom_bazel.sh \
	  test //tensorflow/lite/toco/tflite:operator_test \
	       //tensorflow/lite/toco/tflite:types_test \
	       //tensorflow/lite/toco/tflite:export_test \
	       //tensorflow/lite/toco/tflite:import_test"

###############################################################################
# tags
.PHONY: tags
tags:
	docker run --rm -v $(PWD):$(PWD) -w $(PWD) ctags \
		bash -c "ctags -R ."

###############################################################################
# Update Makefile

update:
	mkdir -p .idea
	rm .idea/Makefile || echo ""
	cp Makefile .idea/


###############################################################################
# doxygen

doxygen-toco:
	docker run --rm \
		-v $(PWD):$(PWD) \
		-w $(PWD)/tensorflow/lite/toco \
		doxygen \
		bash -c "/doxygen/build/bin/doxygen"

open-doxygen-toco:
	xdg-open tensorflow/lite/toco/doxygen/html/index.html

clean-doxygen-toco:
	sudo rm -rf tensorflow/lite/toco/doxygen
