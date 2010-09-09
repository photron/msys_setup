@echo off

rem ===========================================================================
rem   some general variables
rem ===========================================================================

set base_dir=%CD%
set wget=%base_dir%\wget.exe
set zip=%base_dir%\7z\Files\7-Zip\7z.exe
set tmp=%base_dir%\tmp
set msys_dir=%base_dir%\msys
set mingw_dir=%base_dir%\mingw
set git_dir=%base_dir%\git
set python_dir=%base_dir%\python
set go_dir=%base_dir%\go
set msys_url=http://downloads.sourceforge.net/mingw
set mingw_url=http://downloads.sourceforge.net/mingw
set PATH=%PATH%;%msys_dir%\bin

call msys_setup_config.bat


rem ===========================================================================
rem   check for wget.exe
rem ===========================================================================

if exist %wget% goto have_wget
echo error: wget.exe is missing in %base_dir%
goto exit
:have_wget



rem ===========================================================================
rem   check for tmp directory and create if necessary
rem ===========================================================================

if exist %tmp% goto have_tmp
echo creating %tmp% ...
mkdir %tmp%
:have_tmp



rem ===========================================================================
rem   create wget_and_unpack1.bat script
rem ===========================================================================

set out=%tmp%\wget_and_unpack1.bat
echo @echo off                                                      >  %out%
echo rem usage: baseurl filename dstdir                             >> %out%
echo set src=%%1/%%2                                                >> %out%
echo set dst=%%tmp%%\%%2                                            >> %out%
echo set part=%%tmp%%\%%2.part                                      >> %out%
echo set done=%%tmp%%\%%2.done                                      >> %out%
echo if exist %%dst%% goto unpack                                   >> %out%
echo echo downloading %%2 ...                                       >> %out%
echo if exist %%part%% del %%part%%                                 >> %out%
echo %%wget%% %%src%% -O %%part%% ^&^& ren %%part%% %%2             >> %out%
echo if not exist %%dst%% goto error                                >> %out%
echo :unpack                                                        >> %out%
echo if exist %%done%% goto done                                    >> %out%
echo echo unpacking %%2 ...                                         >> %out%
echo %%zip%% x -o%%3 -y %%dst%% ^&^& echo done ^> %%done%%          >> %out%
echo if not exist %%done%% goto error                               >> %out%
echo goto done                                                      >> %out%
echo :error                                                         >> %out%
echo echo error: see possible messages above                        >> %out%
echo :done                                                          >> %out%



rem ===========================================================================
rem   create wget_and_unpack2.bat script
rem ===========================================================================

set out=%tmp%\wget_and_unpack2.bat
echo @echo off                                                      >  %out%
echo rem usage: baseurl filename ext dstdir                         >> %out%
echo set src=%%1/%%2.%%3                                            >> %out%
echo set dst=%%tmp%%\%%2.%%3                                        >> %out%
echo set part=%%tmp%%\%%2.%%3.part                                  >> %out%
echo set done=%%tmp%%\%%2.%%3.done                                  >> %out%
echo if exist %%dst%% goto unpack_outer                             >> %out%
echo echo downloading %%2.%%3 ...                                   >> %out%
echo if exist %%part%% del %%part%%                                 >> %out%
echo %%wget%% %%src%% -O %%part%% ^&^& ren %%part%% %%2.%%3         >> %out%
echo if not exist %%dst%% goto error                                >> %out%
echo :unpack_outer                                                  >> %out%
echo if exist %%tmp%%\%%2 goto unpack_inner                         >> %out%
echo echo unpacking %%2.%%3 ...                                     >> %out%
echo %%zip%% x -o%%tmp%% -y %%dst%%                                 >> %out%
echo if not exist %%tmp%%\%%2 goto error                            >> %out%
echo :unpack_inner                                                  >> %out%
echo if exist %%done%% goto done                                    >> %out%
echo echo unpacking %%2 ...                                         >> %out%
echo %%zip%% x -o%%4 -y %%tmp%%\%%2 ^&^& echo done ^> %%done%%      >> %out%
echo if not exist %%done%% goto error                               >> %out%
echo goto done                                                      >> %out%
echo :error                                                         >> %out%
echo echo error: see possible messages above                        >> %out%
echo :done                                                          >> %out%



rem ===========================================================================
rem   create install_file.bat script
rem ===========================================================================

set out=%tmp%\install_file.bat
echo @echo off                                                      >  %out%
echo rem usage: src dst                                             >> %out%
echo echo install %%1 ...                                           >> %out%
echo copy /y %%1 %%2                                                >> %out%



rem ===========================================================================
rem   download and unpack 7z using msiexec
rem ===========================================================================

set msi=7z465.msi
set zip_url=http://downloads.sourceforge.net/sevenzip

if exist %zip% goto have_zip
if exist %tmp%\%msi% goto unpack_zip
echo downloading %msi% ...
%wget% %zip_url%/%msi% -O %tmp%\%msi%
:unpack_zip
echo unpacking %msi% ...
msiexec /a %tmp%\%msi% TARGETDIR=%base_dir%\7z /qb
:have_zip



rem ===========================================================================
rem   download and unpack python using msiexec
rem ===========================================================================

rem goto skip_python

set msi=python-2.6.5.msi
set python_url=http://python.org/ftp/python/2.6.5

if exist %python_dir%\python.exe goto have_python
if exist %tmp%\%msi% goto unpack_python
echo downloading %msi% ...
%wget% %python_url%/%msi% -O %tmp%\%msi%
:unpack_python
echo unpacking %msi% ...
msiexec /a %tmp%\%msi% TARGETDIR=%python_dir% /qb
:have_python


:skip_python


rem ===========================================================================
rem   check for msys directory and create if necessary
rem ===========================================================================

if exist %msys_dir% goto have_msys_dir
echo creating %msys_dir% ...
mkdir %msys_dir%
:have_msys_dir

if exist %msys_dir%\src goto have_msys_src_dir
echo creating %msys_dir%\src ...
mkdir %msys_dir%\src
:have_msys_src_dir



rem ===========================================================================
rem   download msys
rem ===========================================================================


set out=%tmp%\msys_lzma_packages.txt
echo msysCORE-1.0.11-msys-1.0.11-base-bin.tar          >  %out%
echo coreutils-5.97-2-msys-1.0.11-bin.tar              >> %out%
echo coreutils-5.97-2-msys-1.0.11-ext.tar              >> %out%
echo bash-3.1.17-2-msys-1.0.11-bin.tar                 >> %out%
echo make-3.81-2-msys-1.0.11-bin.tar                   >> %out%
echo tar-1.22-1-msys-1.0.11-bin.tar                    >> %out%
echo gzip-1.3.12-1-msys-1.0.11-bin.tar                 >> %out%
echo sed-4.2.1-1-msys-1.0.11-bin.tar                   >> %out%
echo grep-2.5.4-1-msys-1.0.11-bin.tar                  >> %out%
echo gawk-3.1.7-1-msys-1.0.11-bin.tar                  >> %out%
echo patch-2.5.9-1-msys-1.0.11-bin.tar                 >> %out%
echo diffutils-2.8.7.20071206cvs-2-msys-1.0.11-bin.tar >> %out%
echo findutils-4.4.2-1-msys-1.0.11-bin.tar             >> %out%



rem necessary for autogen.sh
echo perl-5.6.1_2-1-msys-1.0.11-bin.tar     >> %out%
echo libcrypt-1.1_1-2-msys-1.0.11-dll-0.tar >> %out%
echo autoconf-2.63-1-msys-1.0.11-bin.tar    >> %out%
echo automake-1.11-1-msys-1.0.11-bin.tar    >> %out%
echo libtool-2.2.7a-1-msys-1.0.11-bin.tar   >> %out%
echo gettext-0.17-1-msys-1.0.11-bin.tar     >> %out%
echo gettext-0.17-1-msys-1.0.11-dev.tar     >> %out%
echo cvs-1.12.13-1-msys-1.0.11-bin.tar      >> %out%
echo m4-1.4.13-1-msys-1.0.11-bin.tar        >> %out%


set A=for /F %%F in (%tmp%\msys_lzma_packages.txt) do
set B=call %tmp%\wget_and_unpack2.bat %msys_url% %%F lzma %msys_dir%
set C=if not exist %%F.done goto error
%A% %B%; %C%


echo %mingw_dir% /mingw                      >  %msys_dir%\etc\fstab
echo %python_dir% /python                    >> %msys_dir%\etc\fstab
echo %python_dir%\include /include/python2.6 >> %msys_dir%\etc\fstab
echo %python_dir%\Lib\site-packages /lib/python2.6/site-packages >> %msys_dir%\etc\fstab
echo %go_dir% /go                            >> %msys_dir%\etc\fstab




if exist %msys_dir%\etc\profile.d goto have_msys_etc_profiled_dir
echo creating %msys_dir%\etc\profile.d ...
mkdir %msys_dir%\etc\profile.d
:have_msys_etc_profiled_dir




echo export autom4te_perllibdir="/share/autoconf" >  %msys_dir%\etc\profile.d\autoconf.sh
echo export AUTOCONF="/bin/autoconf"              >> %msys_dir%\etc\profile.d\autoconf.sh
echo export AUTOHEADER="/bin/autoheader"          >> %msys_dir%\etc\profile.d\autoconf.sh



echo export GOARCH=386         >  %msys_dir%\etc\profile.d\go.sh
echo export GOBIN=/go/bin      >> %msys_dir%\etc\profile.d\go.sh
echo export GOROOT=/go         >> %msys_dir%\etc\profile.d\go.sh
echo export GOOS=windows       >> %msys_dir%\etc\profile.d\go.sh
echo export PATH=$PATH:$GOBIN  >> %msys_dir%\etc\profile.d\go.sh


echo export PATH=$PATH:/python >  %msys_dir%\etc\profile.d\python.sh



rem ftp://ftp.zlatkovic.com/libxml/   <- for xsltproc




if exist %msys_dir%\bin\wget goto have_msys_wget
if exist %msys_dir%\bin\wget.exe goto have_msys_wget
call %tmp%\install_file.bat %wget% %msys_dir%\bin\wget.exe
:have_msys_wget






rem ===========================================================================
rem   check for mingw directory and create if necessary
rem ===========================================================================

if exist %mingw_dir% goto have_mingw_dir
echo creating %mingw_dir% ...
mkdir %mingw_dir%
:have_mingw_dir


rem set out=%tmp%\mingw_gz_packages.txt
rem echo gcc-core-4.4.0-mingw32-bin.tar     >  %out%
rem echo gcc-core-4.4.0-mingw32-dll.tar     >> %out%
rem echo gcc-c++-4.4.0-mingw32-bin.tar      >> %out%
rem echo gcc-c++-4.4.0-mingw32-dll.tar      >> %out%
rem echo gmp-4.2.4-mingw32-dll.tar          >> %out%
rem echo mpfr-2.4.1-mingw32-dll.tar         >> %out%
rem echo gdb-7.0-2-mingw32-bin.tar          >> %out%
rem echo mingwrt-3.17-mingw32-dll.tar       >> %out%
rem echo mingwrt-3.17-mingw32-dev.tar       >> %out%
rem echo w32api-3.14-mingw32-dev.tar        >> %out%
rem echo binutils-2.20-1-mingw32-bin.tar    >> %out%





set out=%tmp%\mingw_gz_packages.txt
echo mingwrt-3.18-mingw32-dll.tar          >  %out%
echo mingwrt-3.18-mingw32-dev.tar          >> %out%
echo w32api-3.14-mingw32-dev.tar           >> %out%
echo gdb-7.1-2-mingw32-bin.tar             >> %out%
echo binutils-2.20-1-mingw32-bin.tar       >> %out%


set A=for /F %%F in (%tmp%\mingw_gz_packages.txt) do
set B=call %tmp%\wget_and_unpack2.bat %mingw_url% %%F gz %mingw_dir%
set C=if not exist %%F.done goto error
%A% %B%; %C%




set out=%tmp%\mingw_lzma_packages.txt
echo gcc-core-4.5.0-1-mingw32-bin.tar      >  %out%
echo gcc-c++-4.5.0-1-mingw32-bin.tar       >> %out%
echo libgcc-4.5.0-1-mingw32-dll-1.tar      >> %out%
echo libstdc++-4.5.0-1-mingw32-dll-6.tar   >> %out%
echo libgmp-5.0.1-1-mingw32-dll-10.tar     >> %out%
echo libmpc-0.8.1-1-mingw32-dll-2.tar      >> %out%
echo libmpfr-2.4.1-1-mingw32-dll-1.tar     >> %out%


set A=for /F %%F in (%tmp%\mingw_lzma_packages.txt) do
set B=call %tmp%\wget_and_unpack2.bat %mingw_url% %%F lzma %mingw_dir%
set C=if not exist %%F.done goto error
%A% %B%; %C%





rem ===========================================================================
rem   download and fixup gnutls
rem ===========================================================================

call %tmp%\wget_and_unpack1.bat http://josefsson.org/gnutls4win gnutls-2.9.9.zip %msys_dir%

set out=%msys_dir%\bin\fixup_gnutls.sh
echo #!/bin/sh -e                                                                       >  %out%
echo sed -e s:/usr/i586-mingw32msvc::g /lib/libgnutls.la ^> /lib/libgnutls.la.sed       >> %out%
echo mv /lib/libgnutls.la.sed /lib/libgnutls.la                                         >> %out%
echo sed -e s:/usr/i586-mingw32msvc::g /lib/libgcrypt.la ^> /lib/libgcrypt.la.sed       >> %out%
echo mv /lib/libgcrypt.la.sed /lib/libgcrypt.la                                         >> %out%
echo sed -e s:/usr/i586-mingw32msvc::g /lib/libgpg-error.la ^> /lib/libgpg-error.la.sed >> %out%
echo mv /lib/libgpg-error.la.sed /lib/libgpg-error.la                                   >> %out%
echo sed -e s:/usr/i586-mingw32msvc::g /lib/libtasn1.la ^> /lib/libtasn1.la.sed         >> %out%
echo mv /lib/libtasn1.la.sed /lib/libtasn1.la                                           >> %out%

%msys_dir%\bin\sh.exe -e %out%



rem ===========================================================================
rem   download glib
rem ===========================================================================

if %install_glib% NEQ yes goto skip_glib
set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/glib/2.24
call %tmp%\wget_and_unpack1.bat %gnome_url% glib_2.24.0-2_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% glib-dev_2.24.0-2_win32.zip %msys_dir%
:skip_glib


rem ===========================================================================
rem   download gtk
rem ===========================================================================

if %install_gtk% NEQ yes goto skip_gtk
set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/gtk+/2.20
call %tmp%\wget_and_unpack1.bat %gnome_url% gtk+_2.20.0-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% gtk+-dev_2.20.0-1_win32.zip %msys_dir%
:skip_gtk


rem ===========================================================================
rem   download atk
rem ===========================================================================

if %install_atk% NEQ yes goto skip_atk
set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/atk/1.30
call %tmp%\wget_and_unpack1.bat %gnome_url% atk_1.30.0-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% atk-dev_1.30.0-1_win32.zip %msys_dir%
:skip_atk



rem ===========================================================================
rem   download cairo
rem ===========================================================================

if %install_cario% NEQ yes goto skip_cairo
set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% cairo_1.8.10-3_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% cairo-dev_1.8.10-3_win32.zip %msys_dir%
:skip_cairo



rem ===========================================================================
rem   download pango
rem ===========================================================================

if %install_pango% NEQ yes goto skip_pango
set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/pango/1.28
call %tmp%\wget_and_unpack1.bat %gnome_url% pango_1.28.0-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% pango-dev_1.28.0-1_win32.zip %msys_dir%
:skip_pango




rem ===========================================================================
rem   download freetype
rem ===========================================================================

if %install_freetype% NEQ yes goto skip_freetype
set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% freetype_2.3.12-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% freetype-dev_2.3.12-1_win32.zip %msys_dir%
:skip_freetype




rem ===========================================================================
rem   download fontconfig
rem ===========================================================================

if %install_fontconfig% NEQ yes goto skip_fontconfig
set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% fontconfig_2.8.0-2_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% fontconfig-dev_2.8.0-2_win32.zip %msys_dir%
:skip_fontconfig



rem ===========================================================================
rem   download expat
rem ===========================================================================

if %install_expat% NEQ yes goto skip_expat
set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% expat_2.0.1-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% expat-dev_2.0.1-1_win32.zip %msys_dir%
:skip_expat



rem ===========================================================================
rem   download zlib
rem ===========================================================================

if %install_zlib% NEQ yes goto skip_zlib
set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% zlib_1.2.4-2_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% zlib-dev_1.2.4-2_win32.zip %msys_dir%
:skip_zlib



rem ===========================================================================
rem   download libpng
rem ===========================================================================

if %install_libpng% NEQ yes goto skip_libpng
set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% libpng_1.4.0-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% libpng-dev_1.4.0-1_win32.zip %msys_dir%
:skip_libpng



rem ===========================================================================
rem   download libiconv
rem ===========================================================================

if %install_libiconv% NEQ yes goto skip_libiconv
set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% libiconv-1.9.1.bin.woe32.zip %msys_dir%
:skip_libiconv


rem ===========================================================================
rem   download pkg-config
rem ===========================================================================

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% pkg-config_0.23-3_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% pkg-config-dev_0.23-3_win32.zip %msys_dir%



rem ===========================================================================
rem   download git
rem ===========================================================================

rem if %install_git% NEQ yes goto skip_git
call %tmp%\wget_and_unpack1.bat http://msysgit.googlecode.com/files PortableGit-1.6.5.1-preview20091022.7z %git_dir%
echo %git_dir% /git >> %msys_dir%\etc\fstab
echo export PATH=$PATH:/git/bin > %msys_dir%\etc\profile.d\git.sh
:skip_git


rem ===========================================================================
rem   install compile scripts and patches
rem ===========================================================================


if %install_libvirt_scripts% NEQ yes goto skip_libvirt_scripts

call %tmp%\install_file.bat %base_dir%\compile_portablexdr.sh            %msys_dir%\bin\compile_portablexdr.sh
call %tmp%\install_file.bat %base_dir%\portablexdr-4.9.1-signature.patch %msys_dir%\src\portablexdr-4.9.1-signature.patch

call %tmp%\install_file.bat %base_dir%\compile_libxml2.sh                %msys_dir%\bin\compile_libxml2.sh
call %tmp%\install_file.bat %base_dir%\libxml2-2.7.6-pthread.patch       %msys_dir%\src\libxml2-2.7.6-pthread.patch

call %tmp%\install_file.bat %base_dir%\compile_polarssl.sh               %msys_dir%\bin\compile_polarssl.sh
call %tmp%\install_file.bat %base_dir%\polarssl-0.13.1-mingw.patch       %msys_dir%\src\polarssl-0.13.1-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libnss.sh                 %msys_dir%\bin\compile_libnss.sh

call %tmp%\install_file.bat %base_dir%\compile_libcurl.sh                %msys_dir%\bin\compile_libcurl.sh
call %tmp%\install_file.bat %base_dir%\curl-7.19.7-gnutls.patch          %msys_dir%\src\curl-7.19.7-gnutls.patch
call %tmp%\install_file.bat %base_dir%\curl-7.21.1-gnutls.patch          %msys_dir%\src\curl-7.21.1-gnutls.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.8.0.sh          %msys_dir%\bin\compile_libvirt-0.8.0.sh
call %tmp%\install_file.bat %base_dir%\libvirt-0.8.0-mingw.patch         %msys_dir%\src\libvirt-0.8.0-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.8.1.sh          %msys_dir%\bin\compile_libvirt-0.8.1.sh
call %tmp%\install_file.bat %base_dir%\libvirt-0.8.1-mingw.patch         %msys_dir%\src\libvirt-0.8.1-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-git-snapshot.sh   %msys_dir%\bin\compile_libvirt-git-snapshot.sh

set patch=/src/libxml2-2.7.6-pthread.patch
%msys_dir%\bin\sh.exe -ec "sed -e s/\r.$// %patch% > %patch%.sed && mv %patch%.sed %patch%"


:skip_libvirt_scripts


call %tmp%\install_file.bat %base_dir%\compile_lua.sh                    %msys_dir%\bin\compile_lua.sh
call %tmp%\install_file.bat %base_dir%\lua-5.1.4-mingw.patch             %msys_dir%\src\lua-5.1.4-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_glib.sh                   %msys_dir%\bin\compile_glib.sh

call %tmp%\install_file.bat %base_dir%\compile_zlib.sh                   %msys_dir%\bin\compile_zlib.sh

call %tmp%\install_file.bat %base_dir%\compile_cairo.sh                  %msys_dir%\bin\compile_cairo.sh

call %tmp%\install_file.bat %base_dir%\compile_pixman.sh                 %msys_dir%\bin\compile_pixman.sh


goto exit
:error
echo error

pause

:exit
