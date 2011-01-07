#!/bin/sh -ex

dst=/gather/libvirt
bin=$dst/bin
lib=$dst/lib
include=$dst/include
python=$dst/python

mkdir -p $bin
mkdir -p $lib
mkdir -p $include
mkdir -p $python

# bin
cp /bin/virsh.exe $bin
cp /bin/libvirt-0.dll $bin
cp /bin/libvirt-qemu-0.dll $bin
cp /bin/libportablexdr-0.dll $bin
cp /bin/libxml2-2.dll $bin
cp /bin/zlib1.dll $bin
cp /bin/libgnutls-26.dll $bin
cp /bin/libgcrypt-11.dll $bin
cp /bin/libgpg-error-0.dll $bin
cp /bin/libtasn1-3.dll $bin
cp /bin/intl.dll $bin
cp /bin/iconv.dll $bin

if test -f /bin/libcurl-4.dll; then
    cp /bin/libcurl-4.dll $bin
fi

# lib
cp /lib/libvirt.a $lib
cp /lib/libvirt.dll.a $lib
cp /lib/libvirt-qemu.a $lib
cp /lib/libvirt-qemu.dll.a $lib

# include
cp -R /include/libvirt $include

# python
cp /python/Lib/site-packages/libvirt.py $python
cp /python/Lib/site-packages/libvirtmod.dll $python/libvirtmod.pyd

# rewrite imports
pushd $bin

gcc /src/rewriteimports.c -o rewriteimports.exe

imports="libportablexdr-0.dll
libxml2-2.dll
zlib1.dll
libgnutls-26.dll
libgcrypt-11.dll
libgpg-error-0.dll
libtasn1-3.dll
intl.dll
iconv.dll
libcurl-4.dll"

rewriteimports virsh.exe $imports
rewriteimports libvirt-0.dll $imports
rewriteimports libxml2-2.dll $imports
rewriteimports libgcrypt-11.dll $imports
rewriteimports libgnutls-26.dll $imports
rewriteimports libgcrypt-11.dll $imports

if test -f libcurl-4.dll; then
   rewriteimports libcurl-4.dll $imports
fi

rm rewriteimports.exe

mv libportablexdr-0.dll _lv_libportablexdr-0.dll
mv libxml2-2.dll _lv_libxml2-2.dll
mv zlib1.dll _lv_zlib1.dll
mv libgnutls-26.dll _lv_libgnutls-26.dll
mv libgcrypt-11.dll _lv_libgcrypt-11.dll
mv libgpg-error-0.dll _lv_libgpg-error-0.dll
mv libtasn1-3.dll _lv_libtasn1-3.dll
mv intl.dll _lv_intl.dll
mv iconv.dll _lv_iconv.dll

if test -f libcurl-4.dll; then
    mv libcurl-4.dll _lv_libcurl-4.dll
fi

popd
