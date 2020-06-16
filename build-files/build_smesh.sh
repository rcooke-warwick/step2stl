#!/bin/bash

SMESH_VERSION=$1

wget -q https://github.com/tpaviot/smesh/archive/$SMESH_VERSION.tar.gz
tar -xf $SMESH_VERSION.tar.gz
cmake smesh-$SMESH_VERSION
make -j$(nproc --all)
make install
rm -rf * .*
echo -en "\007"

