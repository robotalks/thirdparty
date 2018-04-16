. ${KIT_HOME:=/opt/kit}/functions.sh

test -n "$DEP_MODULE"

ARCH=$1
test -n "$ARCH"

DEP_DIR=$(pwd)

SRC_DIR=$BLD_BASE/src/$DEP_MODULE
BLD_DIR=$BLD_BASE/$ARCH/$DEP_MODULE
OUT_DIR=$OUT_BASE/$ARCH

CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_MODULE_PATH=$OUT_DIR/lib/cmake:$SRC_ROOT/cmake"
case "$ARCH" in
    armhf)
        CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_TOOLCHAIN_FILE=$KIT_HOME/cmake/armhf.toolchain.cmake"
    ;;
esac

clean_copy_src() {
    rm -fr $BLD_DIR
    mkdir -p $(dirname $BLD_DIR)
    cp -rf $SRC_DIR $(dirname $BLD_DIR)/
    cd $BLD_DIR
}

clean_mkdir() {
    rm -fr $BLD_DIR
    mkdir -p $BLD_DIR
    cd $BLD_DIR
}
