#!/usr/bin/env bash
#
set -x

ENV_TYPE=library
APP_NAME=centos
APP_VERSION=7.6.1810
DKP_NAME=registry.tenfz.com
DATETIME=$(date +%F-%H%M%S)

docker pull ${APP_NAME}:${APP_VERSION}

docker build -t ${DKP_NAME}/${ENV_TYPE}/${APP_NAME}:${APP_VERSION} .

docker tag ${DKP_NAME}/${ENV_TYPE}/${APP_NAME}:${APP_VERSION} ${DKP_NAME}/${ENV_TYPE}/${APP_NAME}:${DATETIME}

# docker push ${DKP_NAME}/${ENV_TYPE}/${APP_NAME}:${APP_VERSION}
# docker push ${DKP_NAME}/${ENV_TYPE}/${APP_NAME}:${DATETIME}
