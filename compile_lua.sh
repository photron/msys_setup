#!/bin/sh -ex

base=/src/lua
url=http://www.lua.org/ftp
tarball=lua-5.1.4.tar.gz
directory=lua-5.1.4



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

if [ ! -f mingw.patch.applied ]
then
    echo patching ...
    patch -p1 < ../../lua-5.1.4-mingw.patch
    echo applied > mingw.patch.applied
fi

make

install -p -m 0755 src/lua src/luac src/lua51.dll /bin
install -p -m 0644 src/lua51.dll /bin
install -p -m 0644 src/lua.h src/luaconf.h src/lualib.h src/lauxlib.h /include
install -p -m 0644 src/liblua.a /lib
install -p -m 0644 etc/lua.pc /lib/pkgconfig/lua5.1.pc

popd
popd
