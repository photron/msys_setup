#!/bin/sh -ex

base=/src/libssh2
url=http://www.libssh2.org/download
version=1.2.7
tarball=libssh2-${version}.tar.gz
directory=libssh2-${version}

mkdir -p $base
pushd $base

if [ ! -f $tarball ]
then
    echo downloading $tarball ...
    wget $url/$tarball
fi

if [ ! -d $directory ]
then
    echo unpacking $tarball ...
    tar -xvf $tarball
fi

pushd $directory

if [ ! -f configure.done ]
then
    CFLAGS=-I/include \
    LDFLAGS=-L/lib \
    ./configure --prefix=
    echo done > configure.done
fi

make
make install

popd
popd
