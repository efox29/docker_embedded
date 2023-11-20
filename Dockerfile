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
    ruby \   
    git \
    wget  \
    cppcheck && \
    apt-get clean

ARG TOOLS_PATH=/tool 

ARG ARM_GCC_TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz?rev=e434b9ea4afc4ed7998329566b764309&hash=CA590209F5774EE1C96E6450E14A3E26"
ARG CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v3.27.8/cmake-3.27.8-linux-x86_64.sh"
ARG NINJA_URL="https://github.com/ninja-build/ninja/releases/download/v1.11.1/ninja-linux.zip"

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

#install compiler
RUN wget -qO- ${ARM_GCC_TOOLCHAIN_URL} | tar -xJ --strip-components=1 -C arm-compiler/
#install ninja
RUN wget -qO- ${NINJA_URL} | busybox unzip - -d ninja
RUN chmod +x ninja/ninja

# install ceedling
RUN gem install ceedling

# set paths
ENV PATH="$PATH:$TOOLS_PATH/arm-compiler/bin"
ENV PATH="$PATH:$TOOLS_PATH/cmake/bin"
ENV PATH="$PATH:$TOOLS_PATH/ninja"

RUN mkdir -p /app
WORKDIR /app


    
