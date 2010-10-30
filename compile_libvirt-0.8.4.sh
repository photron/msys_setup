#!/bin/sh -ex

base=/src/libvirt
url=http://libvirt.org/sources
version=0.8.4
tarball=libvirt-${version}.tar.gz
directory=libvirt-${version}

mkdir -p $base
pushd $base

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

if [ ! -f configure.done ]
then
    CFLAGS=-I/include \
    LDFLAGS=-L/lib \
    ./configure --prefix= \
                --enable-debug=yes \
                --without-xen \
                --without-libvirtd \
                --without-openvz \
                --without-lxc \
                --without-vbox \
                --without-phyp \
                --without-python
    echo done > configure.done
fi

make
make install

popd
popd
