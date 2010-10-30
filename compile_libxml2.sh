#!/bin/sh -ex

base=/src/libxml2
url=ftp://xmlsoft.org/libxml2
version=2.7.7
tarball=libxml2-${version}.tar.gz
directory=libxml2-${version}

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

if [ ! -f mingw.patch.applied ]
then
    echo patching ...
    patch -p1 < ../../libxml2-${version}-mingw.patch
    echo applied > mingw.patch.applied
fi

if [ ! -f configure.done ]
then
    CFLAGS=-I/include \
    LDFLAGS=-L/lib \
    ./configure --prefix= --with-python --with-iconv=
    echo done > configure.done
fi

make
make install

# copy libxml2mod.dll to the correct place so python will find it
cp /python/Lib/site-packages/libxml2mod.dll /python/DLLs/libxml2mod.pyd 

popd
popd
