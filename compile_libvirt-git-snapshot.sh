#!/bin/sh -ex

base=/src/libvirt
url=http://libvirt.org/sources

tarball=libvirt-git-snapshot.tar.gz
directory=libvirt-git-snapshot
patch=libvirt-git-snapshot-mingw.patch

mkdir -p $base
pushd $base

#if [ ! -d $directory ]
#then
#    git clone git://libvirt.org/libvirt.git $directory
#fi

if [ ! -f $tarball ]
then
    echo downloading $tarball ...
    wget $url/$tarball
fi

if [ ! -d $directory ]
then
    echo unpacking $tarball ...
    tar -xvf $tarball
fi

pushd $directory

#if [ ! -f mingw.patch.applied ]
#then
#    echo patching ...
#    patch -p1 < ../../$patch
#    echo applied > mingw.patch.applied
#fi

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
