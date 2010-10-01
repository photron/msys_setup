if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% cairo_1.8.10-3_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% cairo-dev_1.8.10-3_win32.zip %msys_dir%




if exist %tmp%\pycairo-1.8.6.win32-py2.6.exe.done goto done_pycairo

set cd_backup=%CD%
cd tmp

if exist pycairo-1.8.6.win32-py2.6.exe goto have_pycairo_archive
%wget% http://ftp.gnome.org/pub/GNOME/binaries/win32/pycairo/1.8/pycairo-1.8.6.win32-py2.6.exe
:have_pycairo_archive

if exist pycairo-1.8.6.win32-py2.6 goto have_pycairo_directory
%zip% x -opycairo-1.8.6.win32-py2.6 pycairo-1.8.6.win32-py2.6.exe
:have_pycairo_directory

cd pycairo-1.8.6.win32-py2.6


xcopy DATA\* %msys_dir% /E /I /Y
xcopy PLATLIB\* %python_dir%\Lib\site-packages /E /I /Y

cd %cd_backup%

echo done > %tmp%\pycairo-1.8.6.win32-py2.6.exe.done

:done_pycairo
