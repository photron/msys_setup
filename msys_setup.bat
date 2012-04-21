@echo off

set sentinel=__sentinel__

rem ===========================================================================
rem   some general variables
rem ===========================================================================

set base_dir=%CD%
set wget=%base_dir%\wget.exe
set zip_dir=%base_dir%\7z\Files\7-Zip
set zip=%zip_dir%\7z.exe
set tmp=%base_dir%\tmp
set msys_dir=%base_dir%\msys
set mingw_dir=%base_dir%\mingw
set git_dir=%base_dir%\git
set python_dir=%base_dir%\python
set perl_dir=%base_dir%\perl
set go_dir=%base_dir%\go
set msys_url=http://downloads.sourceforge.net/mingw
set mingw_url=http://downloads.sourceforge.net/mingw
set PATH=%msys_dir%\bin;%PATH%

call msys_config.bat



if %install_libvirt_scripts% == yes set install_gnutls=yes
if %install_libvirt_scripts% == yes set install_zlib=yes
if %install_libvirt_scripts% == yes set install_python=yes



if %install_python% == yes set install_msvcr90=yes



if %install_virtmanager_scripts% == yes set install_gtk=yes



if %install_gtk% == yes set install_atk=yes
if %install_gtk% == yes set install_pango=yes
if %install_gtk% == yes set install_cario=yes
if %install_gtk% == yes set install_libpng=yes
if %install_gtk% == yes set install_msvcr90=yes



if %install_cario% == yes set install_freetype=yes
if %install_cario% == yes set install_fontconfig=yes
if %install_cario% == yes set install_libpng=yes



if %install_libpng% == yes set install_zlib=yes





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
rem   create wget_and_copy.bat script
rem ===========================================================================

set out=%tmp%\wget_and_copy.bat
echo @echo off                                                      >  %out%
echo rem usage: baseurl filename dstdir                             >> %out%
echo set src=%%1/%%2                                                >> %out%
echo set dst=%%tmp%%\%%2                                            >> %out%
echo set part=%%tmp%%\%%2.part                                      >> %out%
echo set done=%%tmp%%\%%2.done                                      >> %out%
echo if exist %%dst%% goto copy                                     >> %out%
echo echo downloading %%2 ...                                       >> %out%
echo if exist %%part%% del %%part%%                                 >> %out%
echo %%wget%% %%src%% -O %%part%% ^&^& ren %%part%% %%2             >> %out%
echo if not exist %%dst%% goto error                                >> %out%
echo :copy                                                          >> %out%
echo if exist %%done%% goto done                                    >> %out%
echo echo copying %%2 ...                                           >> %out%
echo copy /y %%dst%% %%3 ^> nul ^&^& echo done ^> %%done%%          >> %out%
echo if not exist %%done%% goto error                               >> %out%
echo goto done                                                      >> %out%
echo :error                                                         >> %out%
echo echo error: see possible messages above                        >> %out%
echo :done                                                          >> %out%




rem ===========================================================================
rem   create wget_and_install.bat script
rem ===========================================================================

set out=%tmp%\wget_and_install.bat
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
echo msiexec /a %%dst%% TARGETDIR=%%3 /qb ^&^& echo done ^> %%done%% >> %out%
echo if not exist %%done%% goto error                               >> %out%
echo goto done                                                      >> %out%
echo :error                                                         >> %out%
echo echo error: see possible messages above                        >> %out%
echo :done                                                          >> %out%




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
echo copy /y %%1 %%2 ^> nul                                         >> %out%
echo if not %%ERRORLEVEL%%==0 echo ERROR: installing %%1 failed     >> %out%




rem ===========================================================================
rem   create install_file_silent.bat script
rem ===========================================================================

set out=%tmp%\install_file_silent.bat
echo @echo off                                                      >  %out%
echo rem usage: src dst                                             >> %out%
echo copy /y %%1 %%2 ^> nul                                         >> %out%
echo if not %%ERRORLEVEL%%==0 echo ERROR: installing %%1 failed     >> %out%



rem ===========================================================================
rem   create install_patch.bat script
rem ===========================================================================

set out=%tmp%\install_patch.bat
echo @echo off                                                      >  %out%
echo rem usage: filename                                            >> %out%
echo echo install %base_dir%\%%1 ...                                >> %out%
echo copy /y %base_dir%\%%1 %msys_dir%\src\%%1 ^> nul               >> %out%
echo if not %%ERRORLEVEL%%==0 echo ERROR: installing %base_dir%\%%1 failed >> %out%
echo %msys_dir%\bin\sh.exe -ec "sed -e 's/\r\n$//' /src/%%1 > /src/%%1.sed && mv /src/%%1.sed /src/%%1" >> %out%






rem ===========================================================================
rem   create remove_file_silent.bat script
rem ===========================================================================

set out=%tmp%\remove_file_silent.bat
echo @echo off                                                      >  %out%
echo rem usage: path                                                >> %out%
echo if exist %%1 del %%1 ^> nul                                    >> %out%
echo if not %%ERRORLEVEL%%==0 echo ERROR: removing %%1 failed       >> %out%






rem ===========================================================================
rem   download and unpack 7zip using msiexec
rem ===========================================================================

call msys_setup_7zip.bat






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
echo libcrypt-1.1_1-2-msys-1.0.11-dll-0.tar >> %out%
echo autoconf-2.63-1-msys-1.0.11-bin.tar    >> %out%
echo automake-1.11-1-msys-1.0.11-bin.tar    >> %out%
echo libtool-2.2.7a-1-msys-1.0.11-bin.tar   >> %out%
echo cvs-1.12.13-1-msys-1.0.11-bin.tar      >> %out%
echo m4-1.4.13-1-msys-1.0.11-bin.tar        >> %out%



echo bsdcpio-2.7.1-1-msys-1.0.11-bin.tar         >> %out%
echo libarchive-2.7.1-1-msys-1.0.11-dll-2.tar    >> %out%
echo libopenssl-0.9.8k-1-msys-1.0.11-dll-098.tar >> %out%
echo zlib-1.2.3-2-msys-1.0.13-dll.tar            >> %out%


set A=for /F %%F in (%tmp%\msys_lzma_packages.txt) do
set B=call %tmp%\wget_and_unpack2.bat %msys_url% %%F lzma %msys_dir%
set C=if not exist %%F.done goto error
%A% %B%; %C%




set out=%tmp%\msys_gz_packages.txt
echo xz-4.999.9beta_20100401-1-msys-1.0.13-bin.tar         >  %out%
echo liblzma-4.999.9beta_20100401-1-msys-1.0.13-dll-1.tar  >> %out%
echo libbz2-1.0.5-1-msys-1.0.11-dll-1.tar                  >> %out%


set A=for /F %%F in (%tmp%\msys_gz_packages.txt) do
set B=call %tmp%\wget_and_unpack2.bat %msys_url% %%F gz %msys_dir%
set C=if not exist %%F.done goto error
%A% %B%; %C%





echo %mingw_dir% /mingw                      >  %msys_dir%\etc\fstab
echo %go_dir% /go                            >> %msys_dir%\etc\fstab
echo %zip_dir% /sevenzip                     >> %msys_dir%\etc\fstab
echo %perl_dir% /perl                        >> %msys_dir%\etc\fstab




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
echo export PATH=$GOBIN:$PATH  >> %msys_dir%\etc\profile.d\go.sh







echo export PATH=/sevenzip:$PATH >  %msys_dir%\etc\profile.d\sevenzip.sh



rem ftp://ftp.zlatkovic.com/libxml/   <- for xsltproc




if exist %msys_dir%\bin\wget goto have_msys_wget
if exist %msys_dir%\bin\wget.exe goto have_msys_wget
call %tmp%\install_file.bat %wget% %msys_dir%\bin\wget.exe
:have_msys_wget



rem don't let coreutil's expand.exe shadow the Windows expand.exe
if exist %msys_dir%\bin\expand.exe move %msys_dir%\bin\expand.exe %msys_dir%\bin\expand.exe.msys





rem ===========================================================================
rem   check for mingw directory and create if necessary
rem ===========================================================================

if exist %mingw_dir% goto have_mingw_dir
echo creating %mingw_dir% ...
mkdir %mingw_dir%
:have_mingw_dir


set out=%tmp%\mingw_gz_packages.txt
echo mingwrt-3.18-mingw32-dll.tar          >  %out%
echo mingwrt-3.18-mingw32-dev.tar          >> %out%
echo w32api-3.14-mingw32-dev.tar           >> %out%
echo gdb-7.1-2-mingw32-bin.tar             >> %out%
echo binutils-2.20-1-mingw32-bin.tar       >> %out%
echo libbz2-1.0.5-2-mingw32-dll-2.tar      >> %out%
echo bzip2-1.0.5-2-mingw32-bin.tar         >> %out%



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




rem remove pthread files installed by previous version of the script

call %tmp%\remove_file_silent.bat %mingw_dir%\include\pthread.h
call %tmp%\remove_file_silent.bat %mingw_dir%\include\sched.h
call %tmp%\remove_file_silent.bat %mingw_dir%\include\semaphore.h
call %tmp%\remove_file_silent.bat %mingw_dir%\lib\libpthread.dll.a

call %tmp%\remove_file_silent.bat %mingw_dir%\mingw32\include\pthread.h
call %tmp%\remove_file_silent.bat %mingw_dir%\mingw32\include\sched.h
call %tmp%\remove_file_silent.bat %mingw_dir%\mingw32\include\semaphore.h
call %tmp%\remove_file_silent.bat %mingw_dir%\mingw32\lib\libpthread.a




rem ===========================================================================
rem   install various libs
rem ===========================================================================

call msys_setup_perl.bat
call msys_setup_glib.bat
call msys_setup_libiconv.bat
call msys_setup_pkgconfig.bat
call msys_setup_intltool.bat
call msys_setup_gettext.bat
call msys_setup_expat.bat

if %install_gnutls% == yes call msys_setup_gnutls.bat

if %install_gtk% == yes call msys_setup_gtk.bat

if %install_atk% == yes call msys_setup_atk.bat

if %install_cario% == yes call msys_setup_cairo.bat

if %install_pango% == yes call msys_setup_pango.bat

if %install_freetype% == yes call msys_setup_freetype.bat

if %install_fontconfig% == yes call msys_setup_fontconfig.bat

if %install_git% == yes call msys_setup_git.bat

if %install_msvcr90% == yes call msys_setup_msvcr90.bat

if %install_python% == yes call msys_setup_python.bat

if %install_zlib% == yes call msys_setup_zlib.bat

if %install_libpng% == yes call msys_setup_libpng.bat





rem ===========================================================================
rem   install compile scripts and patches
rem ===========================================================================


if %install_libvirt_scripts% NEQ yes goto skip_libvirt_scripts

call %tmp%\install_file.bat %base_dir%\utilslib.sh                       %msys_dir%\bin\utilslib.sh

call %tmp%\install_file.bat %base_dir%\compile_xhtml1-dtds.sh            %msys_dir%\bin\compile_xhtml1-dtds.sh

call %tmp%\install_file.bat %base_dir%\compile_portablexdr.sh            %msys_dir%\bin\compile_portablexdr.sh
call %tmp%\install_patch.bat portablexdr-4.9.1-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libxml2.sh                %msys_dir%\bin\compile_libxml2.sh
call %tmp%\install_patch.bat libxml2-2.7.6-mingw.patch
call %tmp%\install_patch.bat libxml2-2.7.7-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_polarssl.sh               %msys_dir%\bin\compile_polarssl.sh
call %tmp%\install_patch.bat polarssl-0.13.1-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_yassl.sh                  %msys_dir%\bin\compile_yassl.sh

call %tmp%\install_file.bat %base_dir%\compile_libnss.sh                 %msys_dir%\bin\compile_libnss.sh

call %tmp%\install_file.bat %base_dir%\compile_libcurl.sh                %msys_dir%\bin\compile_libcurl.sh
call %tmp%\install_patch.bat curl-7.19.7-gnutls.patch
call %tmp%\install_patch.bat curl-7.21.1-gnutls.patch
call %tmp%\install_patch.bat curl-7.21.2-gnutls.patch
call %tmp%\install_patch.bat curl-7.21.7-gnutls.patch

call %tmp%\install_file.bat %base_dir%\compile_libssh2.sh                %msys_dir%\bin\compile_libssh2.sh

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.8.0.sh          %msys_dir%\bin\compile_libvirt-0.8.0.sh
call %tmp%\install_patch.bat libvirt-0.8.0-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.8.1.sh          %msys_dir%\bin\compile_libvirt-0.8.1.sh
call %tmp%\install_patch.bat libvirt-0.8.1-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.8.3.sh          %msys_dir%\bin\compile_libvirt-0.8.3.sh
call %tmp%\install_patch.bat libvirt-0.8.3-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.8.4.sh          %msys_dir%\bin\compile_libvirt-0.8.4.sh

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.8.5.sh          %msys_dir%\bin\compile_libvirt-0.8.5.sh
call %tmp%\install_patch.bat libvirt-0.8.5-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.8.6.sh          %msys_dir%\bin\compile_libvirt-0.8.6.sh
call %tmp%\install_patch.bat libvirt-0.8.6-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.8.7.sh          %msys_dir%\bin\compile_libvirt-0.8.7.sh
call %tmp%\install_patch.bat libvirt-0.8.7-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.8.8.sh          %msys_dir%\bin\compile_libvirt-0.8.8.sh
call %tmp%\install_patch.bat libvirt-0.8.8-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.9.0.sh          %msys_dir%\bin\compile_libvirt-0.9.0.sh
call %tmp%\install_patch.bat libvirt-0.9.0-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.9.1.sh          %msys_dir%\bin\compile_libvirt-0.9.1.sh
call %tmp%\install_patch.bat libvirt-0.9.1-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.9.2.sh          %msys_dir%\bin\compile_libvirt-0.9.2.sh
call %tmp%\install_patch.bat libvirt-0.9.2-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.9.3.sh          %msys_dir%\bin\compile_libvirt-0.9.3.sh
call %tmp%\install_patch.bat libvirt-0.9.3-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.9.4.sh          %msys_dir%\bin\compile_libvirt-0.9.4.sh
call %tmp%\install_patch.bat libvirt-0.9.4-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.9.10.sh         %msys_dir%\bin\compile_libvirt-0.9.10.sh
call %tmp%\install_patch.bat libvirt-0.9.10-mingw.patch
call %tmp%\install_file.bat %base_dir%\compile_libvirt-0.9.11.sh         %msys_dir%\bin\compile_libvirt-0.9.11.sh
call %tmp%\install_patch.bat libvirt-0.9.11-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_libvirt-git-snapshot.sh   %msys_dir%\bin\compile_libvirt-git-snapshot.sh
call %tmp%\install_patch.bat libvirt-git-snapshot-mingw.patch

call %tmp%\install_file.bat %base_dir%\gather_libvirt.sh                 %msys_dir%\bin\gather_libvirt.sh
call %tmp%\install_file.bat %base_dir%\rewriteimports.c                  %msys_dir%\src\rewriteimports.c
call %tmp%\install_file.bat %base_dir%\rewritepython.c                   %msys_dir%\src\rewritepython.c

call %tmp%\install_file.bat %base_dir%\download_libvirt-fedora.sh        %msys_dir%\bin\download_libvirt-fedora.sh

:skip_libvirt_scripts





if %install_virtmanager_scripts% NEQ yes goto skip_virtmanager_scripts

call %tmp%\install_file.bat %base_dir%\compile_pycurl.sh                 %msys_dir%\bin\compile_pycurl.sh
call %tmp%\install_patch.bat pycurl-7.19.0-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_urlgrabber.sh             %msys_dir%\bin\compile_urlgrabber.sh

call %tmp%\install_file.bat %base_dir%\compile_virt-install.sh           %msys_dir%\bin\compile_virt-install.sh
call %tmp%\install_patch.bat virtinst-0.500.4-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_gtk-vnc.sh                %msys_dir%\bin\compile_gtk-vnc.sh
call %tmp%\install_patch.bat gtk-vnc-0.4.2-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_virt-manager.sh           %msys_dir%\bin\compile_virt-manager.sh
call %tmp%\install_patch.bat virt-manager-0.8.5-mingw.patch

:skip_virtmanager_scripts





call %tmp%\install_file.bat %base_dir%\compile_lua.sh                    %msys_dir%\bin\compile_lua.sh
call %tmp%\install_patch.bat lua-5.1.4-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_glib.sh                   %msys_dir%\bin\compile_glib.sh

call %tmp%\install_file.bat %base_dir%\compile_zlib.sh                   %msys_dir%\bin\compile_zlib.sh
call %tmp%\install_patch.bat zlib-1.2.5-mingw.patch

call %tmp%\install_file.bat %base_dir%\compile_cairo.sh                  %msys_dir%\bin\compile_cairo.sh

call %tmp%\install_file.bat %base_dir%\compile_pixman.sh                 %msys_dir%\bin\compile_pixman.sh

goto exit
:error
echo error

pause

:exit
