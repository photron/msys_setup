if %sentinel% NEQ __sentinel__ exit

call %tmp%\wget_and_unpack1.bat http://josefsson.org/gnutls4win gnutls-2.10.1.zip %msys_dir%

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
