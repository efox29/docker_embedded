#!/bin/sh

docker buildx build --platform=linux/amd64 -t efox29/arm-toolchain:v1.0.0 --load .