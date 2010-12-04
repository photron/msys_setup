#!/bin/sh -ex

. utilslib.sh

basedir=/src/cairo
baseurl=http://cairographics.org/snapshots
tarball=cairo-1.9.6.tar.gz
directory=cairo-1.9.6

mkdir -p $basedir
pushd $basedir

utilslib_download $baseurl $tarball

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

    CFLAGS=-I/include\ -L/lib ./configure --prefix=

    echo done > configure.done
fi

make
make install


popd
popd
