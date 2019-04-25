#!/bin/sh

NODEPOOL_DOCKERREPO=${NODEPOOL_DOCKERREPO:-"local"}
NODEPOOL_VERSION=${NODEPOOL_VERSION:-"0.5.1"}

if [[ "$NODEPOOL_CLEAN" == "1" ]]; then
    docker image rm ${NODEPOOL_DOCKERREPO}/nodepool-launcher:${NODEPOOL_VERSION}
    docker image rm ${NODEPOOL_DOCKERREPO}/nodepool-builder:${NODEPOOL_VERSION}
fi

docker build --target nodepool-launcher -t ${NODEPOOL_DOCKERREPO}/nodepool-launcher:${NODEPOOL_VERSION} .
docker build --target nodepool-builder -t ${NODEPOOL_DOCKERREPO}/nodepool-builder:${NODEPOOL_VERSION} .

if [[ "$NODEPOOL_PUSH" == "1" ]]; then
    docker push ${NODEPOOL_DOCKERREPO}/nodepool-launcher:${NODEPOOL_VERSION}
    docker push ${NODEPOOL_DOCKERREPO}/nodepool-builder:${NODEPOOL_VERSION}
fi