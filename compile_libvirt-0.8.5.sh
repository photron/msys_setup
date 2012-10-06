#!/bin/sh -ex

. utilslib.sh

basedir=/src/libvirt
baseurl=http://libvirt.org/sources
version=0.8.5
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


# prepare gather
cp src/.libs/libvirt-0.dll $prepare_bin
cp src/.libs/libvirt.dll.a $prepare_lib
cp src/.libs/libvirt.a $prepare_lib
cp src/.libs/libvirt-qemu-0.dll $prepare_bin
cp src/.libs/libvirt-qemu.dll.a $prepare_lib
cp src/.libs/libvirt-qemu.a $prepare_lib
cp tools/.libs/virsh.exe $prepare_bin
mkdir -p $prepare_include/libvirt
cp include/libvirt/libvirt.h $prepare_include/libvirt
cp include/libvirt/libvirt-qemu.h $prepare_include/libvirt
cp include/libvirt/virterror.h $prepare_include/libvirt
cp python/libvirt.py $prepare_python
cp python/.libs/libvirtmod.dll $prepare_python/libvirtmod.pyd
cp ../libvirt-${version}.tar.gz $prepare_src
cp ../../libvirt-${version}-mingw.patch $prepare_src


popd
popd
