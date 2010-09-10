#!/bin/sh -ex

koji=http://kojipkgs.fedoraproject.org/packages
base=/fedora

mkdir -p $base
pushd $base

if [ ! -f mingw32-libvirt-0.8.3-1.fc15.noarch.rpm ]
then
    wget $koji/mingw32-libvirt/0.8.3/1.fc15/noarch/mingw32-libvirt-0.8.3-1.fc15.noarch.rpm
    7z x mingw32-libvirt-0.8.3-1.fc15.noarch.rpm
    bsdcpio -id < mingw32-libvirt-0.8.3-1.fc15.noarch.cpio.lzma
fi

if [ ! -f mingw32-libvirt-debuginfo-0.8.3-1.fc15.noarch.rpm ]
then
    wget $koji/mingw32-libvirt/0.8.3/1.fc15/noarch/mingw32-libvirt-debuginfo-0.8.3-1.fc15.noarch.rpm
    7z x mingw32-libvirt-debuginfo-0.8.3-1.fc15.noarch.rpm
    bsdcpio -id < mingw32-libvirt-debuginfo-0.8.3-1.fc15.noarch.cpio.lzma
fi

if [ ! -f mingw32-gnutls-2.6.4-3.fc13.noarch.rpm ]
then
    wget $koji/mingw32-gnutls/2.6.4/3.fc13/noarch/mingw32-gnutls-2.6.4-3.fc13.noarch.rpm
    7z x mingw32-gnutls-2.6.4-3.fc13.noarch.rpm
    bsdcpio -id < mingw32-gnutls-2.6.4-3.fc13.noarch.cpio.lzma
fi

if [ ! -f mingw32-libgcrypt-1.4.4-4.fc12.noarch.rpm ]
then
    wget $koji/mingw32-libgcrypt/1.4.4/4.fc12/noarch/mingw32-libgcrypt-1.4.4-4.fc12.noarch.rpm
    7z x mingw32-libgcrypt-1.4.4-4.fc12.noarch.rpm
    bsdcpio -id < mingw32-libgcrypt-1.4.4-4.fc12.noarch.cpio.lzma
fi

if [ ! -f mingw32-libgpg-error-1.6-13.fc13.noarch.rpm ]
then
    wget $koji/mingw32-libgpg-error/1.6/13.fc13/noarch/mingw32-libgpg-error-1.6-13.fc13.noarch.rpm
    7z x mingw32-libgpg-error-1.6-13.fc13.noarch.rpm
    bsdcpio -id < mingw32-libgpg-error-1.6-13.fc13.noarch.cpio.lzma
fi

if [ ! -f mingw32-gettext-0.17-12.fc12.noarch.rpm ]
then
    wget $koji/mingw32-gettext/0.17/12.fc12/noarch/mingw32-gettext-0.17-12.fc12.noarch.rpm
    7z x mingw32-gettext-0.17-12.fc12.noarch.rpm
    bsdcpio -id < mingw32-gettext-0.17-12.fc12.noarch.cpio.lzma
fi

if [ ! -f mingw32-iconv-1.12-12.fc12.noarch.rpm ]
then
    wget $koji/mingw32-iconv/1.12/12.fc12/noarch/mingw32-iconv-1.12-12.fc12.noarch.rpm
    7z x mingw32-iconv-1.12-12.fc12.noarch.rpm
    bsdcpio -id < mingw32-iconv-1.12-12.fc12.noarch.cpio.lzma
fi

if [ ! -f mingw32-zlib-1.2.3-19.fc12.noarch.rpm ]
then
    wget $koji/mingw32-zlib/1.2.3/19.fc12/noarch/mingw32-zlib-1.2.3-19.fc12.noarch.rpm
    7z x mingw32-zlib-1.2.3-19.fc12.noarch.rpm
    bsdcpio -id < mingw32-zlib-1.2.3-19.fc12.noarch.cpio.lzma
fi

if [ ! -f mingw32-portablexdr-4.9.1-1.fc15.noarch.rpm ]
then
    wget $koji/mingw32-portablexdr/4.9.1/1.fc15/noarch/mingw32-portablexdr-4.9.1-1.fc15.noarch.rpm
    7z x mingw32-portablexdr-4.9.1-1.fc15.noarch.rpm
    bsdcpio -id < mingw32-portablexdr-4.9.1-1.fc15.noarch.cpio.lzma
fi

if [ ! -f mingw32-libxml2-2.7.6-1.fc13.noarch.rpm ]
then
    wget $koji/mingw32-libxml2/2.7.6/1.fc13/noarch/mingw32-libxml2-2.7.6-1.fc13.noarch.rpm
    7z x mingw32-libxml2-2.7.6-1.fc13.noarch.rpm
    bsdcpio -id < mingw32-libxml2-2.7.6-1.fc13.noarch.cpio.lzma
fi

if [ ! -f mingw32-readline-5.2-7.fc12.noarch.rpm ]
then
    wget $koji/mingw32-readline/5.2/7.fc12/noarch/mingw32-readline-5.2-7.fc12.noarch.rpm
    7z x mingw32-readline-5.2-7.fc12.noarch.rpm
    bsdcpio -id < mingw32-readline-5.2-7.fc12.noarch.cpio.lzma
fi

if [ ! -f mingw32-termcap-1.3.1-8.fc12.noarch.rpm ]
then
    wget $koji/mingw32-termcap/1.3.1/8.fc12/noarch/mingw32-termcap-1.3.1-8.fc12.noarch.rpm
    7z x mingw32-termcap-1.3.1-8.fc12.noarch.rpm
    bsdcpio -id < mingw32-termcap-1.3.1-8.fc12.noarch.cpio.lzma
fi

popd
