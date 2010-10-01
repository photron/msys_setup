#!/bin/sh -e

if [ ! -f /src/intltool-0.40-perl.patch.applied ]
then
    patch -p0 < /src/intltool-0.40-perl.patch
    echo applied > /src/intltool-0.40-perl.patch.applied
fi
