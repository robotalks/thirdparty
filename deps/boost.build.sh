#!/bin/bash

set -ex

DEP_MODULE=boost
. functions.sh

clean_copy_src

B2_VARS=--debug-configuration
case "$ARCH" in
    armhf)
        echo 'using gcc : arm : arm-linux-gnueabihf-g++ ;' >user-config.jam
        B2_VARS="$B2_VARS --user-config=user-config.jam toolset=gcc-arm"
    ;;
esac

./bootstrap.sh --prefix=$OUT_DIR --without-libraries=python,test
./b2 -a -q -d+2 $B2_OPTS \
    target-os=linux threading=multi threadapi=pthread \
    variant=release link=static $B2_VARS \
    install \
    -s ZLIB_BINARY=z \
    -s ZLIB_INCLUDE=$OUT_DIR/include \
    -s ZLIB_LIBPATH=$OUT_DIR/lib \
    -s BZIP2_BINARY=bz2 \
    -s BZIP2_INCLUDE=$OUT_DIR/include \
    -s BZIP2_LIBPATH=$OUT_DIR/lib
