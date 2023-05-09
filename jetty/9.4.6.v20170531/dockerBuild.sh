#!/usr/bin/env bash
#
set -x

ENV_TYPE=library
APP_NAME=jetty
APP_VERSION=9.4.6.v20170531
DKP_NAME=registry.tenfz.com
DATETIME=$(date +%F-%H%M%S)

docker build -t ${DKP_NAME}/${ENV_TYPE}/${APP_NAME}:${APP_VERSION} .
docker tag ${DKP_NAME}/${ENV_TYPE}/${APP_NAME}:${APP_VERSION} ${DKP_NAME}/${ENV_TYPE}/${APP_NAME}:latest

docker push ${DKP_NAME}/${ENV_TYPE}/${APP_NAME}:${APP_VERSION}
docker push ${DKP_NAME}/${ENV_TYPE}/${APP_NAME}:latest
