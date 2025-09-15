#!/bin/bash

#BUILD SCRIPT FOR UNIVERSITY OF DELAWARE'S DARWIN
set -x
set -e

PREFIX="$HOME/LLVM_installs/llvm-clldomp-install"
PATH="/home/users/andrewka/sw/python/Python-3.12.10_install/bin:$HOME/sw/ccache/ccache-4.11.3_install/bin:$HOME/ninja-linux/:$PATH"
export PATH="${PREFIX}/bin:$HOME/cmake/cmake-4.0.1-linux-x86_64/bin:$PATH"
LD_LIBRARY_PATH="/home/users/andrewka/sw/python/Python-3.12.10_install/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="${PREFIX}/lib:${PREFIX}/lib/x86_64-unknown-linux-gnu:${HOME}/LLVM_installs/llvm-complete-libcxx-install/lib/x86_64-unknown-linux-gnu:${LD_LIBRARY_PATH}"
export LIBRARY_PATH="${PREFIX}/lib:${PREFIX}/lib/x86_64-unknown-linux-gnu:${HOME}/LLVM_installs/llvm-complete-libcxx-install/lib/x86_64-unknown-linux-gnu:${LIBRARY_PATH}"
export PKG_CONFIG_PATH="${HOME}/sw/Curl/curl-8.15.0_install/lib/pkgconfig:${PKG_CONFIG_PATH}"
#export LIBRARY_PATH="/home/users/andrewka/sw/libffi/libffi-3.4.8_install/lib:$LIBRARY_PATH"
#export CFLAGS="-I/home/users/andrewka/sw/libffi/libffi-3.4.8_install/include"

#module load gcc/14.0.1
module load cuda/12.8

#git clone -b b6287 https://github.com/ggml-org/llama.cpp.git llama.cpp-b6287
SRC=$HOME/sw/LLAMA_CPP/llama.cpp-b6471
#INSTALL=${SRC}/../llama.cpp-b6471-install
BUILD=${SRC}/../gilg-build-llama.cpp-b6471


#mkdir -p $INSTALL
mkdir -p $BUILD
cd $BUILD

#cmake -B build -DGGML_CUDA=ON
#cmake --build build --config Release

cmake \
  -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_C_COMPILER=clang \
  -D CMAKE_CXX_COMPILER=clang++ \
  -D CMAKE_CUDA_HOST_COMPILER=clang++ \
  -D BUILD_SHARED_LIBS=ON \
  -D GGML_CUDA=ON \
  -D LLAMA_BUILD_TESTS=ON \
  -G Ninja ${SRC}

  #-D CMAKE_INSTALL_PREFIX=${INSTALL} \
  #-D CMAKE_CUDA_ARCHITECTURES="86;89" \

cmake --build .
# --config Release

