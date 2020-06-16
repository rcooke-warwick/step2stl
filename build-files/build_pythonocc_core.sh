#!/bin/bash

PYTHON_OCC_CORE_VERSION=$1

wget -q https://github.com/tpaviot/pythonocc-core/archive/$PYTHON_OCC_CORE_VERSION.tar.gz
tar -xf $PYTHON_OCC_CORE_VERSION.tar.gz

cmake ./pythonocc-core-$PYTHON_OCC_CORE_VERSION \
    -DPYTHON_INCLUDE_DIR=/usr/local/include/python3.6m \
    -DPYTHON_LIBRARY=/usr/local/lib/libpython3.6m.so \
    -DPYTHONOCC_WRAP_SMESH=TRUE

make -j$(nproc --all)
make install
rm -rf * .*
echo -en "\007"

