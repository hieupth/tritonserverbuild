ARG BASE
FROM ${BASE} as builder
FROM ubuntu as runtime
COPY --from=builder /opt/tensorrt /opt/tensorrt