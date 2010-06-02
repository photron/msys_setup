#!/bin/sh -ex

base=/src/portablexdr
url=http://people.redhat.com/~rjones/portablexdr/files/
tarball=portablexdr-4.9.1.tar.gz
directory=portablexdr-4.9.1

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

if [ ! -f signature.patch.applied ]
then
    echo patching ...
    patch -p1 < ../../portablexdr-4.9.1-signature.patch
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
