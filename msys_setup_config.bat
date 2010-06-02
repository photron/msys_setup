

set install_glib=yes
set install_gtk=yes
set install_atk=yes
set install_cario=yes
set install_pango=yes
set install_freetype=yes
set install_fontconfig=yes
set install_libpng=yes
set install_libiconv=yes
set install_expat=yes
set install_git=yes
set install_libvirt_scripts=no


if %install_gtk% == yes set install_glib=yes
if %install_gtk% == yes set install_atk=yes
if %install_gtk% == yes set install_pango=yes

if %install_cario% == yes set install_freetype=yes
if %install_cario% == yes set install_fontconfig=yes
if %install_cario% == yes set install_libpng=yes


if %install_pango% == yes set install_glib=yes


if %install_glib% == yes set install_libiconv=yes


if %install_fontconfig% == yes set install_expat=yes


if %install_libpng% == yes set install_zlib=yes
