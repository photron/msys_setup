#!/bin/sh -ex

. utilslib.sh

basedir=/src/libcurl
baseurl=http://curl.haxx.se/download
#version=7.19.7
#version=7.21.1
version=7.21.2
revision=1
tarball=curl-${version}.tar.gz
directory=curl-${version}-${revision}

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

if [ ! -f gnutls.patch.applied ]
then
    echo patching ...
    patch -p1 < ../../curl-${version}-gnutls.patch
    echo applied > gnutls.patch.applied
fi

if [ ! -f configure.done ]
then
    # with gnutls (LGPL)
    CFLAGS=-I/include \
    LDFLAGS=-L/lib\ -lgcrypt \
    ./configure --prefix= --disable-ldap --without-ssl --with-gnutls=

    # with polarssl (GPL)
    #CFLAGS=-I/include \
    #LDFLAGS=-L/lib \
    #./configure --prefix= --disable-ldap --without-ssl --with-polarssl=

    # with yassl (GPL, with exception for other FOSS licenses like LGPL)
    #CFLAGS=-I/include \
    #LDFLAGS=-L/lib \
    #./configure --prefix= --disable-ldap --without-ssl --with-yassl=

    # with nss (MPL, GPL, LGPL)
    #CFLAGS=-I/include\ -I/opt/nss/include \
    #LDFLAGS=-L/lib\ -L/opt/nss/lib \
    #./configure --prefix= --disable-ldap --without-ssl --without-gnutls --with-nss=/opt/nss

    echo done > configure.done
fi

make
make install

popd
popd
