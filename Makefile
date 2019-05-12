docker-build:
	./tensorflow/tools/ci_build/linux/libtensorflow_cpu.sh

docker-run:
	tensorflow/tools/ci_build/linux/custom_docker_run.sh


tflite-interp:
	tensorflow/tools/ci_build/builds/custom_bazel.sh \
	  test //tensorflow/contrib/lite:interpreter_test

tflite-tutorial:
	tensorflow/tools/ci_build/builds/custom_bazel.sh \
	  build //tensorflow/contrib/lite/tutorials:mnist_tflite
