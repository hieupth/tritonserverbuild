ARG BASE=nvcr.io/nvidia/tensorrt:24.04-py3
ARG TARGET=hieupth/mamba

FROM ${BASE} as builder

FROM ${TARGET} as runtime
COPY --from=builder /opt/tensorrt /opt/tensorrt
