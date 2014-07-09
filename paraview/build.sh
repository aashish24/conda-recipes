#!/bin/sh
# see http://conda.pydata.org/docs/build.html for hacking instructions.

# unpack.
mkdir build
cd build

git submodule update --init

# build.
cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    .. | tee cmake.log 2>&1

make | tee make.log 2>&1
make install | tee install.log 2>&1

# vim: set ai et nu:
