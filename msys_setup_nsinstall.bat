if %sentinel% NEQ __sentinel__ exit

set archive=moztools-static.zip
set moztools_url=http://ftp.mozilla.org/pub/mozilla.org/mozilla/libraries/win32

if exist %msys_dir%\bin\nsinstall.exe goto have_nsinstall
if exist %tmp%\moztools-static\moztools\bin\nsinstall.exe goto copy_nsinstall
if exist %tmp%\%archive% goto unpack_moztools

echo downloading %archive% ...
%wget% %moztools_url%/%archive% -O %tmp%\%archive%

:unpack_moztools
echo unpacking %archive% ...
%zip% x -o%tmp%\moztools-static %tmp%\%archive%

:copy_nsinstall
%tmp%\install_file_silent.bat %tmp%\moztools-static\moztools\bin\nsinstall.exe %msys_dir%\bin\nsinstall.exe

:have_nsinstall
