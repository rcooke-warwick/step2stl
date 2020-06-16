#!/bin/bash

OCE_VERSION=$1

wget -q https://github.com/tpaviot/oce/archive/OCE-$OCE_VERSION.tar.gz
tar -xf OCE-$OCE_VERSION.tar.gz
cmake ./oce-OCE-$OCE_VERSION
make -j$(nproc --all)
make install/strip
rm -rf * .*
echo -en "\007"

