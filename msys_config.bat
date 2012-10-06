if not defined sentinel goto :EOF
if %sentinel% NEQ __sentinel__ goto :EOF

set install_gtk=no
set install_atk=no
set install_cario=no
set install_pango=no
set install_freetype=no
set install_fontconfig=no
set install_git=no
set install_msvcr90=no
set install_python=no
set install_gnutls=no
set install_libiconv=yes
set install_zlib=no
set install_libpng=no
set install_nsinstall=no

set install_libvirt_scripts=yes

set install_virtmanager_scripts=yes

set compile_everything_from_source=yes
