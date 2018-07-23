#!/usr/bin/env bash

set -x

# exit if TRAVIS_TAG is empty, no need to release anything
if [ -z "${TRAVIS_TAG}" ]; then
  exit 0
fi

env

docker login -u $DOCKER_USER -p $DOCKER_PASS
export REPO="danielehc/consul_labs"

docker build -f Dockerfile -t ${REPO}:${TRAVIS_TAG} -t ${REPO}:latest .
#~ docker tag ${REPO} ${REPO}:latest
#~ docker tag ${REPO} ${REPO}:consul_labs-${TRAVIS_TAG}
docker push ${REPO}


set +x
