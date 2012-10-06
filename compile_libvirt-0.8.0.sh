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


# prepare gather
cp src/.libs/libvirt-0.dll $prepare_bin
cp src/.libs/libvirt.dll.a $prepare_lib
cp src/.libs/libvirt.a $prepare_lib
cp tools/.libs/virsh.exe $prepare_bin
mkdir -p $prepare_include/libvirt
cp include/libvirt/libvirt.h $prepare_include/libvirt
cp include/libvirt/virterror.h $prepare_include/libvirt
cp python/libvirt.py $prepare_python
cp python/.libs/libvirtmod.dll $prepare_python/libvirtmod.pyd
cp ../libvirt-${version}.tar.gz $prepare_src
cp ../../libvirt-${version}-mingw.patch $prepare_src


popd
popd
