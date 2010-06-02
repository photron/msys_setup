#!/bin/sh -ex

base=/src/pixman
url=http://cairographics.org/releases/
tarball=pixman-0.18.2.tar.gz
directory=pixman-0.18.2

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

#if [ ! -f mingw.patch.applied ]
#then
#    echo patching ...
#    patch -p1 < ../../lua-5.1.4-mingw.patch
#    echo applied > mingw.patch.applied
#fi


if [ ! -f configure.done ]
then
    CFLAGS=-I/include\ -L/lib ./configure --prefix= --disable-gtk

    echo done > configure.done
fi

make
make install


popd
popd
