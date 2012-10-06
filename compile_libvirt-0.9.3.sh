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
