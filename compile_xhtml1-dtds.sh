#!/bin/sh -ex

. utilslib.sh

basedir=/src/xhtml1-dtds
url=http://www.w3.org/TR/xhtml1/
version=2
tarball=xhtml1.tgz
directory=xhtml1-20020801
xhtml1_dir=/usr/share/xml/xhtml/1.0

mkdir -p $basedir
pushd $basedir

utilslib_download $url $tarball

if [ ! -d $directory ]
then
    echo unpacking $tarball ...
    tar -xvf $tarball
fi


# Create the target dir and move the DTD files there
mkdir -p $xhtml1_dir
cp xhtml1-20020801/DTD/* $xhtml1_dir

# Create the XML catalog file
mkdir -p /etc/xml/
xmlcatalog --noout --create /etc/xml/catalog

# Creating entries in the XML catalog file
xmlcatalog --noout -add public '-//W3C//DTD XHTML 1.0 Strict//EN' "$xhtml1_dir/xhtml1-strict.dtd" /etc/xml/catalog
xmlcatalog --noout -add public '-//W3C//DTD XHTML 1.0 Transitional//EN' "$xhtml1_dir/xhtml1-transitional.dtd" /etc/xml/catalog
xmlcatalog --noout -add public '-//W3C//DTD XHTML 1.0 Frameset//EN' "$xhtml1_dir/xhtml1-frameset.dtd" /etc/xml/catalog
xmlcatalog --noout -add public '-//W3C//ENTITIES Latin 1 for XHTML//EN' "$xhtml1_dir/xhtml-lat1.ent" /etc/xml/catalog
xmlcatalog --noout -add public '-//W3C//ENTITIES Special for XHTML//EN' "$xhtml1_dir/xhtml-special.ent" /etc/xml/catalog
xmlcatalog --noout -add public '-//W3C//ENTITIES Symbols for XHTML//EN' "$xhtml1_dir/xhtml-symbol.ent" /etc/xml/catalog
xmlcatalog --noout -add rewriteSystem 'http://www.w3.org/TR/xhtml1/DTD/' "$xhtml1_dir/" /etc/xml/catalog
xmlcatalog --noout -add rewriteSystem 'http://www.w3.org/TR/2002/REC-xhtml1-20020801/DTD/' "$xhtml1_dir/" /etc/xml/catalog
xmlcatalog --noout -add rewriteURI 'http://www.w3.org/TR/xhtml1/DTD/' "$xhtml1_dir/" /etc/xml/catalog
xmlcatalog --noout -add rewriteURI 'http://www.w3.org/TR/2002/REC-xhtml1-20020801/DTD/' "$xhtml1_dir/" /etc/xml/catalog

popd
