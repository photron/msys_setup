#!/bin/sh -e

if [ ! -f /src/python-2.6.6-sysconfig.patch.applied ]
then
    patch -p0 < /src/python-2.6.6-sysconfig.patch
    echo applied > /src/python-2.6.6-sysconfig.patch.applied
fi
