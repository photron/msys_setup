#!/bin/sh -ex

base=/src/libxml2
url=ftp://xmlsoft.org/libxml2
tarball=libxml2-2.7.6.tar.gz
directory=libxml2-2.7.6

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

if [ ! -f pthread.patch.applied ]
then
    echo patching ...
    patch -p1 < ../../libxml2-2.7.6-pthread.patch
    echo applied > pthread.patch.applied
fi

if [ ! -f configure.done ]
then
    ./configure --prefix=
    echo done > configure.done
fi

make
make install

popd
popd
