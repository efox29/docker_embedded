#!/bin/sh

# This will work on any repository because you pass in the complete repo. So it will always make whatever version you pass as the lastest tag.
# This uses whatever user is logged into docker cli. 

if [ $# -eq 0 ]
  then
    echo "You must provide full name and version eg. efox29/arm-toolchain:v1.0.0"    
    exit
fi

IMAGE_NAME=$1
LATEST_IMAGE_NAME=${IMAGE_NAME%:*}:latest

docker tag ${IMAGE_NAME} ${IMAGE_NAME%:*}:latest
docker push  ${LATEST_IMAGE_NAME}