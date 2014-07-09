#!/bin/sh
# see http://conda.pydata.org/docs/build.html for hacking instructions.

# unpack.
mkdir build
cd build

git submodule update --init

# build.
cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX -DBUILD_TESTING=OFF \
    .. | tee cmake.log 2>&1

make -j7 | tee make.log 2>&1
make install | tee install.log 2>&1

# vim: set ai et nu:
