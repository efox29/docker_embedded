from ubuntu:18.04
# used for the occasional time zone check
ARG DEBIAN_FRONTEND=noninteractive
LABEL Description="Image for building Cortex m3"

# run apt get first so that any changes downstream dont have to run this again
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    
    # install dev tools
    build-essential \
    bzip2 \  
    software-properties-common \
    vim \
    busybox \    
    wget && \
    apt-get clean

ARG TOOLS_PATH=/tool 

ARG ARM_GCC_TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2"
ARG CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v3.21.4/cmake-3.21.4-linux-x86_64.sh"
ARG NINJA_URL="https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip"

RUN mkdir -p ${TOOLS_PATH}/arm-compiler
RUN mkdir -p ${TOOLS_PATH}/cmake
RUN mkdir -p ${TOOLS_PATH}/ninja

WORKDIR ${TOOLS_PATH}

# install llvm compiler 
RUN wget https://apt.llvm.org/llvm.sh 
RUN chmod +x llvm.sh
RUN ./llvm.sh 13 all
RUN rm llvm.sh

#install cmake
RUN wget $CMAKE_URL -O cmake.sh
RUN chmod +x cmake.sh
RUN (echo y; echo y) | ./cmake.sh --prefix=${TOOLS_PATH}/cmake --exclude-subdir
RUN rm cmake.sh

#install ninja
RUN wget -qO- ${ARM_GCC_TOOLCHAIN_URL} | tar -xj --strip-components=1 -C arm-compiler/

RUN wget -qO- ${NINJA_URL} | busybox unzip - -d ninja
RUN chmod +x ninja/ninja

# set paths
ENV PATH="$PATH:$TOOLS_PATH/arm-compiler/bin"
ENV PATH="$PATH:$TOOLS_PATH/cmake/bin"
ENV PATH="$PATH:$TOOLS_PATH/ninja"

RUN mkdir -p /app
WORKDIR /app

# /* if you do TEMP=$(basename *.sh .sh) it will strip the extention. Need to store this in a var and should be good to go*/
    
