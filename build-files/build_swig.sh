#!/bin/bash

SWIG_VERSION=$1

wget -q https://github.com/swig/swig/archive/rel-$SWIG_VERSION.tar.gz
tar -xf rel-$SWIG_VERSION.tar.gz
cd swig-rel-$SWIG_VERSION
./autogen.sh
cd ..
./swig-rel-$SWIG_VERSION/configure
make
make install
rm -rf * .*
echo -en "\007"

