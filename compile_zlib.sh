#!/bin/sh -ex

base=/src/zlib
url=http://zlib.net
tarball=zlib-1.2.5.tar.gz
directory=zlib-1.2.5

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
    CFLAGS=-I/include\ -L/lib\ -Os ./configure --prefix=

    echo done > configure.done
fi

make


popd
popd
