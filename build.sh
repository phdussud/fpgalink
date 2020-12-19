#!/bin/sh

CONFIG=Debug
if [ $# -ge 1 ]; then
  CONFIG=$1
fi

# Maybe configure
if [ ! -e build ]; then
  mkdir build
  cd build
  cmake \
    -G "MinGW Makefiles" \
    -DCMAKE_BUILD_TYPE=${CONFIG} \
    -DBUILD_TESTING=1 \
    -DCMAKE_VERBOSE_MAKEFILE=0 \
    -DCMAKE_INSTALL_PREFIX=../install \
    -DCMAKE_INSTALL_RPATH=\$ORIGIN \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
    ..
  cd ..
fi

# Maybe build
if [ $# -lt 2 ] || [ $2 != "-nobuild" ]; then
  cmake --build build --target install -v
fi
