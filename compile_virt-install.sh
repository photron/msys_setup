#!/bin/sh -ex

. utilslib.sh

basedir=/src/virtinst
baseurl=http://virt-manager.et.redhat.com/download/sources/virtinst
version=0.500.4
tarball=virtinst-${version}.tar.gz
directory=virtinst-${version}

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
    patch -p1 < ../../virtinst-${version}-mingw.patch
    echo applied > mingw.patch.applied
fi

python setup.py install

cp virt-clone /bin/virt-clone
cp virt-convert /bin/virt-convert
cp virt-image /bin/virt-image
cp virt-install /bin/virt-install

popd
popd
