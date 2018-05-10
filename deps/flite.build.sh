#!/bin/bash

set -ex

DEP_MODULE=flite
. functions.sh

clean_copy_src

CONFIG_OPTS=
case "$ARCH" in
    armhf) CONFIG_OPTS=--host=arm-linux-gnueabihf ;;
esac

./configure $CONFIG_OPTS
make
make install DESTDIR=$BLD_DIR/_install
mkdir -p $OUT_DIR/bin
cp -f _install/usr/local/bin/flite $OUT_DIR/bin/
cp -rf _install/usr/local/include $OUT_DIR/
cp -rf _install/usr/local/lib $OUT_DIR/
