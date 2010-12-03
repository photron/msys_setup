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
