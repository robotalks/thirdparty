#!/bin/bash
set -ex

DEP_MODULE=ncsdk
. functions.sh

SUBDIR=
case "$ARCH" in
    amd64) SUBDIR=ncsdk-x86_64 ;;
    armhf) SUBDIR=ncsdk-armv7l ;;
    *)
        echo "Unsupported ARCH $ARCH" >&2
        exit 1
        ;;
esac

mkdir -p $OUT_DIR/include $OUT_DIR/lib/mvnc
cp -f $SRC_DIR/$SUBDIR/api/c/*.h $OUT_DIR/include/
cp -f $SRC_DIR/$SUBDIR/api/c/libmvnc.so.0 $OUT_DIR/lib/mvnc/
cp -f $SRC_DIR/$SUBDIR/fw/MvNCAPI.mvcmd $OUT_DIR/lib/mvnc/
ln -sfT mvnc/libmvnc.so.0 $OUT_DIR/lib/libmvnc.so.0
ln -sfT libmvnc.so.0 $OUT_DIR/lib/libmvnc.so
