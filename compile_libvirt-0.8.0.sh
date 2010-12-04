#!/bin/sh -ex

. utilslib.sh

basedir=/src/libvirt
baseurl=http://libvirt.org/sources
version=0.8.0
tarball=libvirt-${version}.tar.gz
directory=libvirt-${version}
patch=libvirt-${version}-mingw.patch

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
    patch -p1 < ../../$patch
    echo applied > mingw.patch.applied
fi

if [ ! -f configure.done ]
then
    CFLAGS=-I/include\ -L/lib ./configure --prefix= --enable-debug=yes \
                --without-xen --without-libvirtd --without-openvz \
                --without-lxc --without-vbox --without-python

    #CFLAGS=-g\ -ggdb\ -O0\ -I/include\ -L/lib ./configure --prefix= \
    #            --enable-debug=yes --enable-compile-warnings=error \
    #            --without-xen --without-libvirtd --without-openvz \
    #            --without-lxc --without-vbox

    #CFLAGS=-g\ -ggdb\ -O0\ -I/include\ -L/lib ./autogen.sh --prefix= \
    #            --enable-debug=yes --enable-compile-warnings=error \
    #            --without-xen --without-libvirtd --without-openvz \
    #            --without-lxc --without-vbox
    echo done > configure.done
fi


make
make install


popd
popd
