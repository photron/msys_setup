#!/bin/sh -ex

. utilslib.sh

basedir=/src/libxml2
url=ftp://xmlsoft.org/libxml2
version=2.9.0
revision=0
tarball=libxml2-${version}.tar.gz
directory=libxml2-${version}-${revision}

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

if [ -f ../../libxml2-${version}-mingw.patch ]
then
    if [ ! -f mingw.patch.applied ]
    then
        echo patching ...
        patch -p1 < ../../libxml2-${version}-mingw.patch
        echo applied > mingw.patch.applied
    fi
fi

if [ ! -f configure.done ]
then
    CFLAGS=-I/include \
    LDFLAGS=-L/lib \
    ./configure --prefix= --with-python --with-iconv= --with-threads=win32
    echo done > configure.done
fi

make
make install

# copy libxml2mod.dll to the correct place so python will find it
cp /python/Lib/site-packages/libxml2mod.dll /python/DLLs/libxml2mod.pyd


# prepare gather
cp .libs/libxml2-2.dll $prepare_bin
cp ../libxml2-${version}.tar.gz $prepare_src

if [ -f ../../libxml2-${version}-mingw.patch ]
then
    cp ../../libxml2-${version}-mingw.patch $prepare_src
fi


popd
popd
