#!/bin/sh -ex

. utilslib.sh

basedir=/src/pixman
baseurl=http://cairographics.org/releases/
tarball=pixman-0.18.2.tar.gz
directory=pixman-0.18.2

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
    CFLAGS=-I/include\ -L/lib ./configure --prefix= --disable-gtk

    echo done > configure.done
fi

make
make install


popd
popd
