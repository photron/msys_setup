if %sentinel% NEQ __sentinel__ exit

set msi=vcredist_x86.exe
set vcredist_url=http://download.microsoft.com/download/1/1/1/1116b75a-9ec3-481a-a3c8-1777b5381140

if exist %msys_dir%\bin\msvcr90.dll goto have_msvcr90
if exist %tmp%\vcredist_x86\vc_red\nosxs_msvcr90.dll goto copy_msvcr90
if exist %tmp%\vcredist_x86\vc_red.cab goto unpack_vc_red
if exist %tmp%\%msi% goto unpack_vcredist

echo downloading %msi% ...
%wget% %vcredist_url%/%msi% -O %tmp%\%msi%

:unpack_vcredist
echo unpacking %msi% ...
%zip% x -o%tmp%\vcredist_x86 %tmp%\vcredist_x86.exe

:unpack_vc_red
echo unpacking %tmp%\vcredist_x86\vc_red.cab ...
rem %zip% x -o%tmp%\vcredist_x86\vc_red %tmp%\vcredist_x86\vc_red.cab
if not exist %tmp%\vcredist_x86\vc_red mkdir %tmp%\vcredist_x86\vc_red
expand %tmp%\vcredist_x86\vc_red.cab -F:* %tmp%\vcredist_x86\vc_red

:copy_msvcr90
copy /Y %tmp%\vcredist_x86\vc_red\nosxs_msvcr90.dll %msys_dir%\bin\msvcr90.dll

:have_msvcr90
