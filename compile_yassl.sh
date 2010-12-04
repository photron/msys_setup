#!/bin/sh -ex

. utilslib.sh

basedir=/src/cyassl
baseurl=http://www.yassl.com
version=2.0.0
tarball=yassl-${version}.zip
directory=yassl-${version}

mkdir -p $basedir
pushd $basedir

utilslib_download $baseurl $tarball

if [ ! -d $directory ]
then
    echo unpacking $tarball ...
    7z x $tarball
fi

pushd $directory

#if [ ! -f mingw.patch.applied ]
#then
#    echo patching ...
#    patch -p1 < ../../polarssl-${version}-mingw.patch
#    echo applied > mingw.patch.applied
#fi

if [ ! -f configure.done ]
then
    CFLAGS=-I/include LDFLAGS=-L/lib ./configure --prefix= 
    echo done > configure.done
fi

make
#make install

popd
popd
