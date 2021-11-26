from ubuntu:18.04

LABEL Description="Image for building Brightlync"

ARG TOOLS_PATH=/tool 
ARG ARM_GCC_TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2"


RUN mkdir -p ${TOOLS_PATH}/arm-compiler
WORKDIR ${TOOLS_PATH}

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \

    # install dev tools
    build-essential \
    bzip2 \
    wget && \
    apt-get clean

RUN wget -qO- ${ARM_GCC_TOOLCHAIN_URL} | tar -xj --strip-components=1 -C arm-compiler/


ENV PATH="$PATH:$TOOLS_PATH/arm-compiler/bin"

RUN mkdir -p /app
WORKDIR /app


    
