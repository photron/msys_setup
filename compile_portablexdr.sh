#!/bin/sh -ex

. utilslib.sh

basedir=/src/portablexdr
baseurl=http://people.redhat.com/~rjones/portablexdr/files/
version=4.9.1
revision=2
tarball=portablexdr-${version}.tar.gz
directory=portablexdr-${version}-${revision}

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
    patch -p1 < ../../portablexdr-${version}-mingw.patch
    echo applied > mingw.patch.applied
fi

if [ ! -f configure.done ]
then
    ./configure --prefix=
    echo done > configure.done
fi

make
make install


# prepare gather
cp .libs/libportablexdr-0.dll $prepare_bin
cp ../portablexdr-${version}.tar.gz $prepare_src
cp ../../portablexdr-${version}-mingw.patch $prepare_src


popd
popd
