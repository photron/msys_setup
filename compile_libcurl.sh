#!/bin/sh -ex

base=/src/libcurl
url=http://curl.haxx.se/download
#version=7.19.7
version=7.21.1
tarball=curl-${version}.tar.gz
directory=curl-${version}


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

if [ ! -f gnutls.patch.applied ]
then
    echo patching ...
    patch -p1 < ../../curl-${version}-gnutls.patch
    echo applied > gnutls.patch.applied
fi

if [ ! -f configure.done ]
then
    # with gnutls (LGPL), (might) report TLS package length error on runtime
    #CFLAGS=-I/include LDFLAGS=-L/lib\ -lgcrypt ./configure --prefix= --disable-ldap --without-ssl --with-gnutls=

    # with polarssl (GPL)
    CFLAGS=-I/include LDFLAGS=-L/lib\ -lgcrypt ./configure --prefix= --disable-ldap --without-ssl --with-polarssl=

    # with nss (MPL, GPL, LGPL)
    #CFLAGS=-I/include LDFLAGS=-L/lib\ -lgcrypt ./configure --prefix= --disable-ldap --without-ssl --with-nss=

    echo done > configure.done
fi

make
make install

popd
popd
