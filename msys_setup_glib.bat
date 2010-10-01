if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/glib/2.24
call %tmp%\wget_and_unpack1.bat %gnome_url% glib_2.24.0-2_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% glib-dev_2.24.0-2_win32.zip %msys_dir%



if exist %tmp%\pygobject-2.20.0.win32-py2.6.exe.done goto done_pygobject

set cd_backup=%CD%
cd tmp

if exist pygobject-2.20.0.win32-py2.6.exe goto have_pygobject_archive
%wget% http://ftp.gnome.org/pub/GNOME/binaries/win32/pygobject/2.20/pygobject-2.20.0.win32-py2.6.exe
:have_pygobject_archive

if exist pygobject-2.20.0.win32-py2.6 goto have_pygobject_directory
%zip% x -opygobject-2.20.0.win32-py2.6 pygobject-2.20.0.win32-py2.6.exe
:have_pygobject_directory

cd pygobject-2.20.0.win32-py2.6


xcopy DATA\* %msys_dir% /E /I /Y
xcopy PLATLIB\* %python_dir%\Lib\site-packages /E /I /Y

cd %cd_backup%


echo done > %tmp%\pygobject-2.20.0.win32-py2.6.exe.done

:done_pygobject



set codegen_dir=%msys_dir%\share\pygobject\2.0\codegen
set h2def=%codegen_dir%\h2def.py

if not exist %codegen_dir% mkdir %codegen_dir%

echo #!/usr/bin/python                                             >  %h2def%
echo import sys                                                    >> %h2def%
echo while len(sys.path) ^> 0 and sys.path[0].endswith("codegen"): >> %h2def%
echo     del sys.path[0]                                           >> %h2def%
echo import codegen.h2def                                          >> %h2def%
echo if __name__ == '__main__':                                    >> %h2def%
echo     sys.exit(codegen.h2def.main(sys.argv))                    >> %h2def%


set codegen=%codegen_dir%\codegen.py

echo #!/usr/bin/python                                             >  %codegen%
echo import sys                                                    >> %codegen%
echo while len(sys.path) ^> 0 and sys.path[0].endswith("codegen"): >> %codegen%
echo     del sys.path[0]                                           >> %codegen%
echo import codegen.codegen                                        >> %codegen%
echo if __name__ == '__main__':                                    >> %codegen%
echo     sys.exit(codegen.codegen.main(sys.argv))                  >> %codegen%



set pygobjectcodegen=%msys_dir%\bin\pygobject-codegen-2.0

echo #!/bin/sh                                       >  %pygobjectcodegen%
echo prefix=                                         >> %pygobjectcodegen%
echo datarootdir=${prefix}/share                     >> %pygobjectcodegen%
echo datadir=${datarootdir}                          >> %pygobjectcodegen%
echo codegendir=${datadir}/pygobject/2.0/codegen     >> %pygobjectcodegen%
echo PYTHONPATH=$codegendir                          >> %pygobjectcodegen%
echo export PYTHONPATH                               >> %pygobjectcodegen%
echo exec /bin/python $codegendir/codegen.py "$@"    >> %pygobjectcodegen%
