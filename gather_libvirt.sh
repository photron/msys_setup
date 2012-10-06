#!/bin/sh -ex

prepare=/gather/libvirt-prepare
dst=/gather/libvirt
bin=$dst/bin
lib=$dst/lib
include=$dst/include
python=$dst/python
python26=$dst/python26
python27=$dst/python27

rm -rf $dst
cp -R $prepare $dst

# bin
cp /bin/libgnutls-26.dll $bin
cp /bin/libgcrypt-11.dll $bin
cp /bin/libgpg-error-0.dll $bin
cp /bin/libtasn1-3.dll $bin
cp /bin/intl.dll $bin

# python26
mv $python $python26

# python27
cp -R $python26 $python27

pushd $python27

gcc /src/rewritepython.c -o rewritepython.exe
rewritepython $python27/libvirtmod.pyd
rm rewritepython.exe

popd

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
libiconv-2.dll
libcurl-4.dll"

rewriteimports virsh.exe $imports
rewriteimports libvirt-0.dll $imports
rewriteimports libvirt-qemu-0.dll $imports
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
mv libiconv-2.dll _lv_libiconv-2.dll

if test -f libcurl-4.dll; then
    mv libcurl-4.dll _lv_libcurl-4.dll
fi

popd
