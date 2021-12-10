#!/bin/bash

if [ -z ${PLUGIN_CTLADDR} ]; then
  PLUGIN_CTLADDR="tcp://0.0.0.0:1234"
fi

if [ -z ${PLUGIN_IMAGE} ]; then
  PLUGIN_IMAGE="harbor.eswin.cn/ci-tool/fail-build"
fi

if [ -z ${PLUGIN_TAG} ]; then
  PLUGIN_TAG="latest"
fi

if [ -z ${PLUGIN_INSECURE} ]; then
  PLUGIN_TAG="false"
fi


buildctl \
    --addr ${PLUGIN_CTLADDR} \
    build \
    --frontend=dockerfile.v0 \
    --local context=. \
    --local dockerfile=. \
    --output type=image,push=true,name=${PLUGIN_IMAGE}:${PLUGIN_TAG},registry.insecure=${PLUGIN_INSECURE} \
    --import-cache type=local,src=/cache
    --export-cache type=local,src=/cache