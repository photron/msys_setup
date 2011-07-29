#!/bin/sh -ex

. utilslib.sh

basedir=/src/libvirt
baseurl=http://libvirt.org/sources
version=0.9.3
revision=0
tarball=libvirt-${version}.tar.gz
directory=libvirt-${version}-${revision}

mkdir -p $basedir
pushd $basedir

utilslib_download $baseurl $tarball

if [ ! -d $directory ]
then
    echo unpacking $tarball ...
    mkdir -p $directory
    tar -xvf $tarball -C $directory --strip-components=1
fi

pushd $directory

if [ ! -f mingw.patch.applied ]
then
    echo patching ...
    patch -p1 < ../../libvirt-${version}-mingw.patch
    echo applied > mingw.patch.applied
fi

if [ -d /include/libvirt ]
then
    # remove previously installed libvirt header files. specifying -I/include
    # makes the build pickup the old headers instead of it's own files.
    # removing the old header files is a simple workaround for this problem.
    rm -r /include/libvirt
fi

if [ ! -f configure.done ]
then
    CFLAGS=-I/include \
    LDFLAGS=-L/lib \
    ./configure --prefix= \
                --without-libvirtd \
                --without-openvz \
                --without-lxc \
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
