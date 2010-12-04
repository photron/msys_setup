#!/bin/sh -ex

. utilslib.sh

basedir=/src/libvirt
baseurl=http://libvirt.org/sources
version=0.8.4
tarball=libvirt-${version}.tar.gz
directory=libvirt-${version}

mkdir -p $basedir
pushd $basedir

utilslib_download $baseurl $tarball

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
