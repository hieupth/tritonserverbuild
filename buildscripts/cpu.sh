#!/bin/bash

set -ex;

git clone https://github.com/triton-inference-server/server.git
cd server
git checkout r${NV_VERSION}
python3 build.py \
  --enable-logging \
  --endpoint=grpc \
  --endpoint=http \
  --backend repeat \
  --backend ensemble \
  --backend python \
  --backend onnxruntime