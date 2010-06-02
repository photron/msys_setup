#!/bin/sh -ex

base=/src/libcurl
url=http://curl.haxx.se/download
tarball=curl-7.19.7.tar.gz
directory=curl-7.19.7



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
    patch -p1 < ../../curl-7.19.7-gnutls.patch
    echo applied > gnutls.patch.applied
fi

if [ ! -f configure.done ]
then
    # with gnutls
    CFLAGS=-I/include\ -L/lib ./configure --prefix= --disable-ldap --without-ssl --with-gnutls=
    # with openssl
    #CFLAGS=-I/include\ -L/lib ./configure --prefix= --disable-ldap
    echo done > configure.done
fi

make
make install

popd
popd
