#!/bin/sh -ex

. utilslib.sh

basedir=/src/libssh2
baseurl=http://www.libssh2.org/download
version=1.2.7
tarball=libssh2-${version}.tar.gz
directory=libssh2-${version}

mkdir -p $basedir
pushd $basedir

utilslib_download $baseurl $tarball

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
