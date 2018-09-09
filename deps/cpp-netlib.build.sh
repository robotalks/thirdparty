#!/bin/bash
set -ex

DEP_MODULE=cpp-netlib
. functions.sh

CMAKE_OPTS=
if [ "$ARCH" == "armhf" ]; then
    CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_TOOLCHAIN_FILE=$KIT_HOME/cmake/armhf.toolchain.cmake"
fi

clean_mkdir

cmake $CMAKE_OPTS \
    -DBOOST_INCLUDEDIR=$OUT_DIR/include \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DCPP-NETLIB_BUILD_TESTS=OFF \
    -DCPP-NETLIB_BUILD_EXAMPLES=OFF \
    -DCPP-NETLIB_ENABLE_HTTPS=OFF \
    $SRC_DIR

make $MAKE_OPTS
make install DESTDIR=./_install

mkdir -p $OUT_DIR
cp -rf _install/usr/local/* $OUT_DIR/
