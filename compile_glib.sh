#!/bin/sh -ex

. utilslib.sh

basedir=/src/glib
baseurl=http://ftp.gnome.org/pub/gnome/sources/glib/2.24
tarball=glib-2.24.0.tar.gz
directory=glib-2.24.0

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
    patch -p1 < ../../lua-5.1.4-mingw.patch
    echo applied > mingw.patch.applied
fi

exit

if [ ! -f configure.done ]
then

    CFLAGS=-I/include\ -L/lib\ -Os ./configure --prefix=

    echo done > configure.done
fi

make


popd
popd
