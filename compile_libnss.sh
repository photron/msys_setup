#!/bin/sh -ex

base=/src/libnss
url=ftp://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/NSS_3_12_7_RTM/src
version=3.12.7
tarball=nss-${version}-with-nspr-4.8.6.tar.gz
directory=nss-${version}
patch=nss-${version}-mingw.patch

#http://ftp.mozilla.org/pub/mozilla.org/mozilla/libraries/win32/MozillaBuildSetup-1.5.exe

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

#if [ ! -f mingw.patch.applied ]
#then
#    echo patching ...
#    patch -p1 < ../../$patch
#    echo applied > mingw.patch.applied
#fi

#if [ ! -f configure.done ]
#then
#    CFLAGS=-I/include LDFLAGS=-L/lib ../configure --prefix= --enable-debug=yes \
#                --without-xen --without-libvirtd --without-openvz \
#                --without-lxc --without-vbox --without-python
#    echo done > configure.done
#fi

#make
#make install

popd
popd
