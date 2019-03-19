#!/bin/sh

ZUUL_DOCKERREPO=${NODEPOOL_DOCKERREPO:-"local"}
ZUUL_VERSION=${NODEPOOL_VERSION:-"0.5.1"}

docker build --target nodepool -t ${NODEPOOL_DOCKERREPO}/nodepool:${NODEPOOL_VERSION} .
docker build --target nodepool-launcher -t ${NODEPOOL_DOCKERREPO}/nodepool-launcher:${NODEPOOL_VERSION} .
docker build --target nodepool-builder -t ${NODEPOOL_DOCKERREPO}/nodepool-builder:${NODEPOOL_VERSION} .