#!/bin/sh -ex

. utilslib.sh

basedir=/src/portablexdr
baseurl=http://people.redhat.com/~rjones/portablexdr/files/
version=4.9.1
revision=1
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

if [ ! -f signature.patch.applied ]
then
    echo patching ...
    patch -p1 < ../../portablexdr-${version}-signature.patch
    echo applied > signature.patch.applied
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
