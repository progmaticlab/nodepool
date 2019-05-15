#!/bin/bash -e

# $1 - name of component to build. all components will be built if not present

NODEPOOL_DOCKERREPO=${NODEPOOL_DOCKERREPO:-"local"}
NODEPOOL_VERSION=${NODEPOOL_VERSION:-"0.5.1"}

function build() {
  local name=$1
  if [[ "$NODEPOOL_CLEAN" == "1" ]]; then
    docker image rm ${NODEPOOL_DOCKERREPO}/nodepool-$name:${NODEPOOL_VERSION}
  fi
  docker build --target nodepool-launcher -t ${NODEPOOL_DOCKERREPO}/nodepool-$name:${NODEPOOL_VERSION} .
  if [[ "$NODEPOOL_PUSH" == "1" ]]; then
    docker push ${NODEPOOL_DOCKERREPO}/nodepool-$name:${NODEPOOL_VERSION}
  fi
}

if [[ -n "$1" ]]; then
  build $1
else
  build launcher
  build builder
fi
