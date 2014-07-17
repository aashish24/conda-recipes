#!/bin/sh
# see http://conda.pydata.org/docs/build.html for hacking instructions.

# unpack.
mkdir build
cd build

git submodule update --init

# build.
cmake \
    -D "CMAKE_CXX_FLAGS:STRING=-fvisibility=hidden -fvisibility-inlines-hidden ${CFLAGS}" \
    -D "CMAKE_C_FLAGS:STRING=-fvisibility=hidden ${CXXFLAGS}" \
    -D "CMAKE_INSTALL_PREFIX=:PATH=$PREFIX" \
    -D CMAKE_OSX_DEPLOYMENT_TARGET:STRING=${MACOSX_DEPLOYMENT_TARGET} \
    -D BUILD_TESTING:BOOL=OFF \
    -D CMAKE_BUILD_TYPE:STRING=RELEASE \
    -D BUILD_SHARED_LIBS:BOOL=OFF \
    -D PARAVIEW_ENABLE_PYTHON:BOOL=ON \
    -D "PYTHON_EXECUTABLE:FILEPATH=${PYTHON}" \
    -D "PYTHON_INCLUDE_PATH:PATH=$PREFIX/include/python${PY_VER}" \
    -D "PYTHON_LIBRARY:FILEPATH=$PREFIX/lib/libpython${PY_VER}.${SO_EXT}" \
    "${SRC_DIR}/SuperBuild" \
    ..


cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX -DBUILD_TESTING=OFF \
    .. | tee cmake.log 2>&1

make -j7 | tee make.log 2>&1
make install | tee install.log 2>&1

# vim: set ai et nu:
