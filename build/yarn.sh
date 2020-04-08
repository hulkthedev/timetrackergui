#!/usr/bin/env bash

set -eo pipefail

BUILD_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_DIR="$(dirname "${BUILD_DIR}")";

CACHE_VOLUME=timetrackerservice-yarn-cache

docker volume create --name ${CACHE_VOLUME} &> /dev/null

docker run --rm -i -t \
    -v yarn-cache:/tmp/yarn-cache \
    -v "${PROJECT_DIR}":/app \
    -w="/app" \
    --entrypoint="yarn" \
    "node:13.12.0-alpine3.11" --cache-folder=/tmp/yarn-cache "$@"

RESULT=$?

#echo -n "fixing permissions... "
#docker run --rm -v "$(pwd)":/data busybox chown -R $(id -u):$(id -g) /data
#echo "done"

exit ${RESULT}
