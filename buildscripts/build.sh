#!/bin/bash

set -ex;

# Default backends (always included)
DEFAULT_BACKENDS="repeat ensemble python"

# Determine additional backends based on BACKEND variable
case "${BACKEND}" in
  tensorrt)
    ADDITIONAL_BACKENDS="onnxruntime tensorrt"
    ;;
  vllm)
    ADDITIONAL_BACKENDS="vllm"
    ;;
  ort)
    ADDITIONAL_BACKENDS="onnxruntime"
    ;;
  *)
    ADDITIONAL_BACKENDS=""
    ;;
esac

# Clone and checkout
git clone https://github.com/triton-inference-server/server.git
cd server
git checkout r${NV_VERSION}

# Build command
BUILD_CMD="python3 build.py --enable-logging --endpoint=grpc --endpoint=http"

# Add GPU flag if enabled
if [ "${ENABLE_GPU}" = "true" ]; then
  BUILD_CMD="${BUILD_CMD} --enable-gpu"
fi

# Add backends
for backend in ${DEFAULT_BACKENDS} ${ADDITIONAL_BACKENDS}; do
  BUILD_CMD="${BUILD_CMD} --backend ${backend}"
done

# Execute build
eval ${BUILD_CMD}
