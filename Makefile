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

tflite-interp:
	tensorflow/tools/ci_build/linux/custom_docker_run.sh \
	  bash -c \
	  "tensorflow/tools/ci_build/builds/custom_bazel.sh \
	  test //tensorflow/contrib/lite:interpreter_test"

tflite-tutorial:
	tensorflow/tools/ci_build/linux/custom_docker_run.sh \
	  bash -c \
	  "tensorflow/tools/ci_build/builds/custom_bazel.sh \
	  build //tensorflow/contrib/lite/tutorials:mnist_tflite"

###############################################################################
# examples
test-regression:
	tensorflow/tools/ci_build/linux/custom_docker_run.sh \
	  bash -c \
	  "tensorflow/tools/ci_build/builds/custom_bazel.sh \
	  test //tensorflow/examples/get_started/regression:test"

###############################################################################
# toco

toco-test:
	tensorflow/tools/ci_build/linux/custom_docker_run.sh \
	  bash -c \
	  "tensorflow/tools/ci_build/builds/custom_bazel.sh \
	  test //tensorflow/contrib/lite/toco/tflite:operator_test \
	       //tensorflow/contrib/lite/toco/tflite:types_test \
	       //tensorflow/contrib/lite/toco/tflite:export_test \
	       //tensorflow/contrib/lite/toco/tflite:import_test"

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
