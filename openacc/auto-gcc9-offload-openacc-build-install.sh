#!/bin/bash

####  A simple automation script to build GCC offload tools, by Philip LoCascio (c) 2015.
####     from https://raw.githubusercontent.com/olcf/OLCFHack15/master/GCC5OffloadTest/auto-gcc5-offload-openacc-build-install.sh
####  Modified by Soren Rasmussen s.rasmussen@cranfield.ac.uk on 5/15/2019
set -e -x

download_files=1
build_files=1

## PROJECT_DIR default value is current directory
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC=${PROJECT_DIR}/src
BUILD=${PROJECT_DIR}/build
INSTALL=${PROJECT_DIR}/install
export CUDA=/opt/cuda/9.1
export LD_LIBRARY_PATH=$CUDA/lib64:$LD_LIBRARY_PATH

## some build params
gcc_ver=gcc-9.1.0
np=4
LCC="gcc"
LCXX="g++"

mkdir -p ${PROJECT_DIR}
cd ${PROJECT_DIR}

if (( ${download_files} )); then
    mkdir -p ${SRC}
    cd ${SRC}
    git clone https://github.com/MentorEmbedded/nvptx-newlib.git
    git clone https://github.com/MentorEmbedded/nvptx-tools.git

    wget ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/${gcc_ver}/${gcc_ver}.tar.gz
    tar -zxf ${gcc_ver}.tar.gz
    rm -fr gcc
    mv ${gcc_ver} gcc
fi


if (( ${build_files} )); then
    echo "Building nvptx-tools : GPU assembler and linking tools"
    mkdir -p $BUILD/nvptx-build
    cd $BUILD/nvptx-build
    $SRC/nvptx-tools/configure \
	--prefix=$INSTALL \
	--target=nvptx-none \
	--with-cuda-driver-include=$CUDA/include \
	--with-cuda-driver-lib=$CUDA/lib64 \
	--with-cuda-runtime-include=$CUDA/include \
	--with-cuda-runtime-lib=$CUDA/lib64 \
	CC="$LCC -m64" \
	CXX="$LCXX -m64"
    make -j ${np}
    make install

    if [ ! -f $SRC/gcc/gmp-6.1.0   ]; then
	echo "Building GCC prerequisites"
	cd $SRC/gcc
	contrib/download_prerequisites --no-verify
    fi

    echo "Building GCC with nvptx-none target(offload compiler)"
    mkdir -p $BUILD/${gcc_ver}-accel
    cd $BUILD/${gcc_ver}-accel
    ln -vs $SRC/nvptx-newlib/newlib $SRC/gcc/newlib
    ln -vs . $INSTALL/nvptx-none/usr
    target=$($SRC/gcc/config.guess)
    $SRC/gcc/configure \
	--prefix= \
	--target=nvptx-none \
	--enable-as-accelerator-for="$target" \
	--enable-languages=c,c++,fortran,lto \
	--enable-checking=yes,df,fold,rtl \
	--disable-multilib \
	--with-sysroot=$INSTALL/nvptx-none \
	--with-build-sysroot=$INSTALL/nvptx-none \
	--with-build-time-tools=$INSTALL/nvptx-none/bin \
	--disable-sjlj-exceptions \
	--enable-newlib-io-long-long \
	CC="$LCC -m64" \
	CXX="$LCXX -m64"
    make -j ${np}
    make DESTDIR=$INSTALL install

    mkdir -p $BUILD/${gcc_ver}
    cd $BUILD/${gcc_ver}
    $SRC/gcc/configure \
	--prefix= \
	--disable-bootstrap \
	--enable-languages=c,c++,fortran,lto \
	--disable-multilib \
	--enable-offload-targets=nvptx-none=$INSTALL \
	--with-cuda-driver-include=$CUDA/include \
	CC="$LCC -m64" \
	CXX="$LCXX -m64" \
	--with-sysroot=
    make -j ${np}
    make DESTDIR=$INSTALL install

fi # end if build_project

echo "Done building. Now try the tests"
echo "Be sure to add"
echo "   ${INSTALL}/install/bin          to PATH"
echo "   ${INSTALL}/install/lib64        to LIBRARY_PATH"
echo "   ${INSTALL}/install/lib64        to LD_LIBRARY_PATH"
echo "   ${INSTALL}/install/include/c++  to CPLUS_INCLUDE_PATH"
