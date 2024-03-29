#!/bin/sh -e
set -x #echo on

cd ~
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel; yum clean all -y
wget -nv https://www.python.org/ftp/python/3.9.13/Python-3.9.13.tar.xz
tar xf Python-3.9.13.tar.xz
cd Python-3.9.13
./configure --prefix=/usr/local --with-openssl=/usr/local/openssl
make install -j$(nproc)
cd ~
rm -rf Python-*

pip3 install -U pip setuptools websocket-client
