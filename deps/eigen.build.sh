#!/bin/bash
set -ex

DEP_MODULE=eigen
. functions.sh

clean_mkdir

cmake $SRC_DIR
make install DESTDIR=`pwd`/install
cp -rf install/usr/local/include/eigen3 $OUT_DIR/include/
