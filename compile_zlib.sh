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

#if [ ! -f configure.done ]
#then
#    CFLAGS=-I/include\ -L/lib\ -Os ./configure --prefix=
#
#    echo done > configure.done
#fi

make -f win32/Makefile.gcc
INCLUDE_PATH=/include LIBRARY_PATH=/lib make -f win32/Makefile.gcc install


popd
popd
