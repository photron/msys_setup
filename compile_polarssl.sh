#!/bin/sh -ex

. utilslib.sh

basedir=/src/polarssl
baseurl=http://www.polarssl.org/code/releases
version=0.13.1
tarball=polarssl-${version}-gpl.tgz
directory=polarssl-${version}

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
    patch -p1 < ../../polarssl-${version}-mingw.patch
    echo applied > mingw.patch.applied
fi

CC=gcc make
CC=gcc make install

popd
popd
