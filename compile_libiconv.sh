#!/bin/sh -ex

. utilslib.sh

basedir=/src/libiconv
url=http://ftp.gnu.org/pub/gnu/libiconv
version=1.13.1
tarball=libiconv-${version}.tar.gz
directory=libiconv-${version}

mkdir -p $basedir
pushd $basedir

utilslib_download $url $tarball

if [ ! -d $directory ]
then
    echo unpacking $tarball ...
    mkdir -p $directory
    tar -xvf $tarball -C $directory --strip-components=1
fi

pushd $directory

#if [ ! -f mingw.patch.applied ]
#then
#    echo patching ...
#    patch -p1 < ../../libxml2-${version}-mingw.patch
#    echo applied > mingw.patch.applied
#fi

if [ ! -f configure.done ]
then
    CFLAGS=-I/include \
    LDFLAGS=-L/lib \
    ./configure --prefix=
    echo done > configure.done
fi

make
make install


# prepare gather
cp lib/.libs/libiconv-2.dll $prepare_bin
cp ../libiconv-${version}.tar.gz $prepare_src


popd
popd
