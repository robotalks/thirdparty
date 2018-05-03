#!/bin/bash

set -ex

DEP_MODULE=sphinx
. functions.sh

clean_copy_src

HOST_OPT=
case "$ARCH" in
    armhf) HOST_OPT="--host=arm-linux-gnueabihf" ;;
esac

cd $BLD_DIR/sphinxbase
./configure $HOST_OPT --disable-shared --enable-static --without-python
make $MAKE_OPTS
make install DESTDIR=`pwd`/_install

# the make script hard-coded automake-1.13, create a symbolic link for that
# as latest toolchain doesn't have this old version
mkdir $BLD_DIR/bin
ln -s $(which aclocal) $BLD_DIR/bin/aclocal-1.13
ln -s $(which automake) $BLD_DIR/bin/automake-1.13
export PATH=$PATH:$BLD_DIR/bin

cd $BLD_DIR/pocketsphinx
./autogen.sh $HOST_OPT --disable-shared --enable-static --without-python
./configure $HOST_OPT --disable-shared --enable-static --without-python
make $MAKE_OPTS
make install DESTDIR=`pwd`/_install

mkdir -p $OUT_DIR
cp -rf $BLD_DIR/sphinxbase/_install/usr/local/* $OUT_DIR/
cp -rf $BLD_DIR/pocketsphinx/_install/usr/local/* $OUT_DIR/
