#!/bin/sh

docker buildx build --platform=linux/x86_64 -t efox29/arm-toolchain:v2.0.0 --load .