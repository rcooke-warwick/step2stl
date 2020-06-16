#!/bin/bash

FREETYPE_VERSION=$1

wget -q https://download.savannah.gnu.org/releases/freetype/freetype-$FREETYPE_VERSION.tar.gz
tar -xf freetype-$FREETYPE_VERSION.tar.gz
./freetype-$FREETYPE_VERSION/configure
make
make install
rm -rf * .*
echo -en "\007"

