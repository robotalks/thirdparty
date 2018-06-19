#!/bin/bash
set -ex

DEP_MODULE=opencv
. functions.sh

CMAKE_OPTS=
TARGET_ABI=
case "$ARCH" in
    amd64)
        TARGET_ABI=x86_64-linux-gnu
        ;;
    armhf)
        TARGET_ABI=arm-linux-gnueabihf
        CMAKE_OPTS="$CMAKE_OPTS -DENABLE_VFPV3=ON -DENABLE_NEON=ON -DWITH_TBB=ON -DBUILD_TBB=ON"
        CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_TOOLCHAIN_FILE=$SRC_DIR/platforms/linux/arm-gnueabi.toolchain.cmake"
        ;;
    *)
        echo "unsupported arch $ARCH" >&2
        exit 1
        ;;
esac

clean_mkdir

export PKG_CONFIG_PATH=$OUT_DIR/lib/pkgconfig:/usr/lib/$TARGET_ABI/pkgconfig:/usr/share/pkgconfig
export PKG_CONFIG_LIBDIR=$PKG_CONFIG_PATH
export CPATH=$OUT_DIR/include:$OUT_BASE/noarch/include:/usr/include:/usr/include/$TARGET_ABI
export INCLUDE=$CPATH
export LIBRARY_PATH=$OUT_DIR/lib:/usr/lib:/usr/lib/$TARGET_ABI
mkdir -p eigen_root
cp -rf $OUT_BASE/noarch/include/eigen3 eigen_root/include
export EIGEN_ROOT=`pwd`/eigen_root
cmake $CMAKE_OPTS \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_DOCS=OFF \
    -DBUILD_JPEG=ON \
    -DBUILD_PNG=ON \
    -DBUILD_TIFF=ON \
    -DBUILD_ZLIB=ON \
    -DBUILD_JASPER=ON \
    -DBUILD_OPENEXR=ON \
    -DWITH_EIGEN=ON \
    -DCMAKE_PREFIX_PATH=/usr/local \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DOPENCV_EXTRA_MODULES_PATH=$BLD_BASE/src/opencv_contrib/modules \
    -DGFLAGS_INCLUDE_DIR=$OUT_DIR/include \
    -DGFLAGS_LIBRARY=$OUT_DIR/lib/libgflags.a \
    -DGLOG_INCLUDE_DIR=$OUT_DIR/include \
    -DGLOG_LIBRARY=$OUT_DIR/lib/libglog.a \
    $SRC_DIR

make $MAKE_OPTS
make install DESTDIR=./_install

mkdir -p $OUT_DIR
cp -rf _install/usr/local/* $OUT_DIR/
