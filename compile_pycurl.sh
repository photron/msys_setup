#!/bin/sh -ex

. utilslib.sh

basedir=/src/pycurl
baseurl=http://pycurl.sourceforge.net/download
version=7.19.0
tarball=pycurl-${version}.tar.gz
directory=pycurl-${version}

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
    patch -p1 < ../../pycurl-${version}-mingw.patch
    echo applied > mingw.patch.applied
fi

python setup.py build --curl-dir=/src/libcurl/curl-7.21.2-1 --compiler=mingw32
python setup.py install --curl-dir=/src/libcurl/curl-7.21.2-1

popd
popd
