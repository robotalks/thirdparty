#!/bin/bash
set -ex

DEP_MODULE=googletest
. functions.sh

clean_mkdir

export PKG_CONFIG_PATH=$OUT_DIR/lib/pkgconfig
cmake $CMAKE_OPTS \
    -DCMAKE_BUILD_TYPE=Debug -DBUILD_SHARED_LIBS=OFF \
    $SRC_DIR
make $MAKE_OPTS
make install DESTDIR=./_install
mkdir -p $OUT_DIR
cp -rf _install/usr/local/* $OUT_DIR/
