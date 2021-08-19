#!/bin/bash -e
set -x #echo on
cd ~
wget -nv --no-check-certificate --content-disposition https://github.com/apache/xerces-c/archive/v2.8.0.tar.gz
tar xf xerces-c-2.8.0.tar.gz
cd xerces-c-2.8.0/src/xercesc
export XERCESCROOT=~/xerces-c-2.8.0
./runConfigure -p linux
make
cd ../..
cp -r include/xercesc /usr/include/
cp lib/libxerces-c.so.28.0 /usr/lib/
ln -sf /usr/lib/libxerces-c.so.28.0 /usr/lib/libxerces-c.so
cd ~
rm -rf xerces-c-2.8.0*
