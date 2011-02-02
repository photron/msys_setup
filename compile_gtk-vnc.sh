#!/bin/sh -ex

. utilslib.sh

basedir=/src/gtk-vnc
baseurl=http://ftp.gnome.org/pub/GNOME/sources/gtk-vnc/0.4
version=0.4.2
tarball=gtk-vnc-${version}.tar.gz
directory=gtk-vnc-${version}


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
    patch -p1 < ../../gtk-vnc-${version}-mingw.patch
    echo applied > mingw.patch.applied
fi

if [ ! -f configure.done ]
then
    CFLAGS=-I/include\ -I/python/include \
    LDFLAGS=-L/lib \
    ./configure --prefix= --without-sasl --with-python
    echo done > configure.done
fi

make
make install

# copy gtkvnc.dll to the correct place so python will find it
cp /python/Lib/site-packages/gtkvnc.dll /python/DLLs/gtkvnc.pyd 

popd
popd
