#!/bin/sh

if [ $# -eq 0 ]
  then
    echo "You must provide full name and version eg. efox29/arm-toolchain:v1.0.0"    
    exit
fi

IMAGE_NAME=$1
LATEST_IMAGE_NAME=${IMAGE_NAME%:*}:latest

docker tag ${IMAGE_NAME} ${IMAGE_NAME%:*}:latest
docker push  ${LATEST_IMAGE_NAME}