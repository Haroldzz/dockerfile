#!/usr/bin/env bash
#
set -ex

ENV_TYPE=library
APP_NAME=centos
APP_VERSION=7.6.1810

DKP_URL=uhub.service.docker.cn
DKP_NAME=basic
DATETIME=$(date +%F-%H%M%S)

docker pull ${APP_NAME}:${APP_VERSION}
docker build -t ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${APP_VERSION} .
docker tag ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${APP_VERSION} ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${DATETIME}

docker push ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${DATETIME}
docker push ${DKP_URL}/${DKP_NAME}/${APP_NAME}:${APP_VERSION}
