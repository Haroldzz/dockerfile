#!/usr/bin/env bash
#
set -ex

ENV_TYPE=library
APP_NAME=oraclejdk
APP_VERSION=8u131

DKP_URL=uhub.service.docker.cn
DKP_NAME=basic
DATETIME=$(date +%F-%H%M%S)

docker build -t ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${APP_VERSION} .
docker tag ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${APP_VERSION} ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${DATETIME}

docker push ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${DATETIME}
docker push ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${APP_VERSION}
