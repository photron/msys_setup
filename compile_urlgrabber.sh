#!/bin/sh -ex

. utilslib.sh

basedir=/src/urlgrabber
baseurl=http://urlgrabber.baseurl.org/download
version=3.9.1
tarball=urlgrabber-${version}.tar.gz
directory=urlgrabber-${version}

mkdir -p $basedir
pushd $basedir

utilslib_download $baseurl $tarball

if [ ! -d $directory ]
then
    echo unpacking $tarball ...
    tar -xvf $tarball
fi

pushd $directory

python setup.py install

popd
popd
