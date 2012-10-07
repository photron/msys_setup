#!/bin/sh -ex

. utilslib.sh

basedir=/src/libvirt
baseurl=http://libvirt.org/sources
tarball=libvirt-git-snapshot.tar.gz
directory=libvirt-git-snapshot
patch=libvirt-git-snapshot-mingw.patch

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
    patch -p1 < ../../$patch
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
    CFLAGS=-I/include\ -g\ -ggdb\ -O0\ -march=i686 \
    LDFLAGS=-L/lib \
    ./configure --prefix= \
                --enable-debug=yes \
                --without-xen \
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
