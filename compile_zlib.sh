#!/bin/sh -ex

. utilslib.sh

basedir=/src/zlib
baseurl=http://zlib.net
version=1.2.5
tarball=zlib-${version}.tar.gz
directory=zlib-${version}

mkdir -p $basedir
pushd $basedir

utilslib_download $baseurl $tarball

if [ ! -d $directory ]
then
    echo unpacking $tarball ...
    tar -xvf $tarball
fi

pushd $directory

if [ ! -f mingw.patch.applied ]
then
    echo patching ...
    patch -p1 < ../../zlib-${version}-mingw.patch
    echo applied > mingw.patch.applied
fi


make -fwin32/Makefile.gcc
cp libz-1.dll /bin
cp libz.dll.a /lib
cp libz.a /lib
cp zlib.h /include
cp zconf.h /include




popd
popd
