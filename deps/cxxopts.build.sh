#!/bin/bash

set -ex

DEP_MODULE=cxxopts
. functions.sh

mkdir -p $OUT_DIR/include
wget -nv -O $OUT_DIR/include/cxxopts.hpp \
    https://raw.githubusercontent.com/jarro2783/cxxopts/v1.4.4/include/cxxopts.hpp
