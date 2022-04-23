#!/bin/sh
export MSYS_NO_PATHCONV=1
docker run -it --rm -v $(pwd):/app arm-toolchain bash