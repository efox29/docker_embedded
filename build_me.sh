#!/bin/sh

docker buildx build --platform=linux/amd64 -t arm-toolchain --load .