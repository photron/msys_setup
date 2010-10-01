#!/bin/sh -e

for def in \
    /share/pygtk/2.0/defs/gdk.defs \
    /share/pygtk/2.0/defs/gdk-types.defs \
    /share/pygtk/2.0/defs/gtk.defs \
    /share/pygtk/2.0/defs/gtk-types.defs \
    ; do
    sed -e 's/include "gtk\/\(.*\)/include "\1/' "$def" > "$def-tmp"
    mv "$def-tmp" "$def"
done
