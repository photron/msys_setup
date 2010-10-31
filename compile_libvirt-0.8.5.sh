#!/bin/sh -ex

base=/src/libvirt
url=http://libvirt.org/sources
version=0.8.5
tarball=libvirt-${version}.tar.gz
directory=libvirt-${version}
patch=libvirt-${version}-mingw.patch

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

if [ ! -f mingw.patch.applied ]
then
    echo patching ...
    patch -p1 < ../../$patch
    echo applied > mingw.patch.applied
fi

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
                --with-python
    echo done > configure.done
fi

make
make install

# copy libvirtmod.dll to the correct place so python will find it
cp /python/Lib/site-packages/libvirtmod.dll /python/DLLs/libvirtmod.pyd 

popd
popd
