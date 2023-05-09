#!/usr/bin/env bash
#
set -ex

ENV_TYPE=library
APP_NAME=redis
APP_VERSION=5.0.6

DKP_URL=uhub.service.docker.cn
DKP_NAME=basic
DATETIME=$(date +%F-%H%M%S)

docker build -t ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${APP_VERSION} .
docker tag ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${APP_VERSION} ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${DATETIME}

docker push ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${DATETIME}
docker push ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${APP_VERSION}
