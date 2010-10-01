if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/gtk+/2.20
call %tmp%\wget_and_unpack1.bat %gnome_url% gtk+_2.20.0-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% gtk+-dev_2.20.0-1_win32.zip %msys_dir%

set gnome_url=http://ftp.gnome.org/pub/GNOME/binaries/win32/libglade/2.6
call %tmp%\wget_and_unpack1.bat %gnome_url% libglade_2.6.4-1_win32.zip %msys_dir%



call %tmp%\install_file.bat %base_dir%\patch_pygtk.sh %msys_dir%\bin\patch_pygtk.sh



if exist %tmp%\pygtk-2.16.0+glade.win32-py2.6.exe.done goto done_pygtk

set cd_backup=%CD%
cd tmp

if exist pygtk-2.16.0+glade.win32-py2.6.exe goto have_pygtk_archive
%wget% http://ftp.gnome.org/pub/GNOME/binaries/win32/pygtk/2.16/pygtk-2.16.0+glade.win32-py2.6.exe
:have_pygtk_archive

if exist pygtk-2.16.0+glade.win32-py2.6 goto have_pygtk_directory
%zip% x -opygtk-2.16.0+glade.win32-py2.6 pygtk-2.16.0+glade.win32-py2.6.exe
:have_pygtk_directory

cd pygtk-2.16.0+glade.win32-py2.6


xcopy DATA\* %msys_dir% /E /I /Y
xcopy PLATLIB\* %python_dir%\Lib\site-packages /E /I /Y

cd %cd_backup%

rem xcopy %python_dir%\Lib\site-packages\gtk-2.0\gtk\_gtk.pyd %python_dir%\DLLs\gtk\ /E /I /Y

echo done > %tmp%\pygtk-2.16.0+glade.win32-py2.6.exe.done

:done_pygtk


set pygtkcodegen=%msys_dir%\bin\pygtk-codegen-2.0

echo #!/bin/sh                                       >  %pygtkcodegen%
echo prefix=                                         >> %pygtkcodegen%
echo datarootdir=${prefix}/share                     >> %pygtkcodegen%
echo datadir=${datarootdir}                          >> %pygtkcodegen%
echo codegendir=${datadir}/pygobject/2.0/codegen     >> %pygtkcodegen%
echo PYTHONPATH=$codegendir                          >> %pygtkcodegen%
echo export PYTHONPATH                               >> %pygtkcodegen%
echo exec /bin/python $codegendir/codegen.py "$@"    >> %pygtkcodegen%




%msys_dir%\bin\sh.exe -ec patch_pygtk.sh
