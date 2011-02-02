#!/bin/sh -ex

. utilslib.sh


# virt-manager --no-dbus --no-fork


basedir=/src/virt-manager
baseurl=http://virt-manager.et.redhat.com/download/sources/virt-manager
version=0.8.5
tarball=virt-manager-${version}.tar.gz
directory=virt-manager-${version}

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
    patch -p1 < ../../virt-manager-${version}-mingw.patch
    echo applied > mingw.patch.applied
fi

if [ ! -f configure.done ]
then
    ./configure --prefix=
    echo done > configure.done
fi

make
make install

popd
popd
