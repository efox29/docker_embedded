from ubuntu:18.04

LABEL Description="Image for building Cortex m3"

ARG TOOLS_PATH=/tool 
ARG ARM_GCC_TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2"
ARG CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v3.21.4/cmake-3.21.4-linux-x86_64.sh"

RUN mkdir -p ${TOOLS_PATH}/arm-compiler
RUN mkdir -p ${TOOLS_PATH}/cmake
WORKDIR ${TOOLS_PATH}

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \

    # install dev tools
    build-essential \
    bzip2 \    
    wget && \    
    apt-get clean

RUN wget $CMAKE_URL -O cmake.sh
RUN chmod +x cmake.sh
RUN (echo y; echo y) | ./cmake.sh --prefix=${TOOLS_PATH}/cmake --exclude-subdir
RUN rm cmake.sh

RUN wget -qO- ${ARM_GCC_TOOLCHAIN_URL} | tar -xj --strip-components=1 -C arm-compiler/


ENV PATH="$PATH:$TOOLS_PATH/arm-compiler/bin"
ENV PATH="$PATH:$TOOLS_PATH/cmake/bin"

RUN mkdir -p /app
WORKDIR /app

# /* if you do TEMP=$(basename *.sh .sh) it will strip the extention. Need to store this in a var and should be good to go*/
    
