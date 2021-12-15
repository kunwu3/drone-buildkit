#!/bin/bash

if [ -z ${PLUGIN_ADDR} ]; then
  exit 1
fi

if [ -z ${PLUGIN_REPO} ]; then
  exit 1
fi

if [ -z ${PLUGIN_REGISTRY} ]; then
  PLUGIN_REGISTRY="docker.io"
fi

if [ -z ${PLUGIN_TAG} ]; then
  PLUGIN_TAG="latest"
fi

if [ -z ${PLUGIN_INSECURE} ]; then
  PLUGIN_INSECURE="false"
fi

if [ -z ${PLUGIN_DOCKERSRC} ]; then
  PLUGIN_DOCKERSRC=""
fi

if [ -z ${PLUGIN_AUTH} ]; then
  PLUGIN_AUTH=""
fi

echo ${PLUGIN_AUTH} > /root/.docker/config.json

echo "Pushing image to ${PLUGIN_REGISTRY}/${PLUGIN_REPO}:${PLUGIN_TAG}"

buildctl \
    --addr ${PLUGIN_ADDR} \
    build \
    --frontend=dockerfile.v0 \
    --local context=. \
    --local dockerfile=./${PLUGIN_DOCKERSRC} \
    --output type=image,push=true,name=${PLUGIN_REGISTRY}/${PLUGIN_REPO}:${PLUGIN_TAG},registry.insecure=${PLUGIN_INSECURE} \
    --export-cache type=local,dest=./image-build-cache \
    --import-cache type=local,src=./image-build-cache
