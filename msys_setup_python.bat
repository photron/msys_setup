if %sentinel% NEQ __sentinel__ exit

call %tmp%\wget_and_install.bat http://python.org/ftp/python/2.6.6 python-2.6.6.msi %python_dir%


set crt_dir=%python_dir%\Microsoft.VC90.CRT
if exist %crt_dir%\Microsoft.VC90.CRT.manifest goto have_msvcr90
if not exist %crt_dir% mkdir %crt_dir%
call %tmp%\install_file.bat %tmp%\vcredist_x86\vc_red\manifest.21022.08.Microsoft_VC90_CRT_x86.RTM %crt_dir%\Microsoft.VC90.CRT.manifest
call %tmp%\install_file.bat %tmp%\vcredist_x86\vc_red\nosxs_msvcm90.dll %crt_dir%\msvcm90.dll
call %tmp%\install_file.bat %tmp%\vcredist_x86\vc_red\nosxs_msvcp90.dll %crt_dir%\msvcp90.dll
call %tmp%\install_file.bat %tmp%\vcredist_x86\vc_red\nosxs_msvcr90.dll %crt_dir%\msvcr90.dll
:have_msvcr90


if not exist %python_dir%\include\python2.6 mkdir %python_dir%\include\python2.6
dir /b %python_dir%\include\*.h > %tmp%\python2.6_headers.txt
for /f %%F in (%tmp%\python2.6_headers.txt) do call %tmp%\install_file_silent.bat %python_dir%\include\%%F %python_dir%\include\python2.6\%%F



call %tmp%\install_file.bat %base_dir%\python-config    %msys_dir%\bin\python-config
call %tmp%\install_file.bat %base_dir%\python-config    %msys_dir%\bin\python2.6-config
call %tmp%\install_file.bat %base_dir%\python-config.py %msys_dir%\bin\python-config.py

call %tmp%\install_file.bat %base_dir%\patch_python.sh %msys_dir%\bin\patch_python.sh
call %tmp%\install_patch.bat python-2.6.6-sysconfig.patch



echo %python_dir% /python                    >> %msys_dir%\etc\fstab
echo %python_dir%\include /include/python2.6 >> %msys_dir%\etc\fstab
echo %python_dir%\Lib\site-packages /lib/python2.6/site-packages >> %msys_dir%\etc\fstab


echo #!/bin/sh                                                              >  %msys_dir%\bin\python
echo case $# in                                                             >> %msys_dir%\bin\python
echo 0) exec /python/python ;;                                              >> %msys_dir%\bin\python
echo 1) exec /python/python "$1" ;;                                         >> %msys_dir%\bin\python
echo 2) exec /python/python "$1" "$2" ;;                                    >> %msys_dir%\bin\python
echo 3) exec /python/python "$1" "$2" "$3" ;;                               >> %msys_dir%\bin\python
echo 4) exec /python/python "$1" "$2" "$3" "$4" ;;                          >> %msys_dir%\bin\python
echo 5) exec /python/python "$1" "$2" "$3" "$4" "$5" ;;                     >> %msys_dir%\bin\python
echo 6) exec /python/python "$1" "$2" "$3" "$4" "$5" "$6" ;;                >> %msys_dir%\bin\python
echo 7) exec /python/python "$1" "$2" "$3" "$4" "$5" "$6" "$7" ;;           >> %msys_dir%\bin\python
echo 8) exec /python/python "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;      >> %msys_dir%\bin\python
echo 9) exec /python/python "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" ;; >> %msys_dir%\bin\python
echo *) exec /python/python "$@" ;;                                         >> %msys_dir%\bin\python
echo esac                                                                   >> %msys_dir%\bin\python



%msys_dir%\bin\sh.exe -ec patch_python.sh


echo export PATH=/python/Lib/site-packages:$PATH >  %msys_dir%\etc\profile.d\python.sh



rem add dummy/fake stuff for virt-manager

set site_dir=%python_dir%\Lib\site-packages

call %tmp%\install_file.bat %base_dir%\python-fcntl.py %site_dir%\fcntl.py
call %tmp%\install_file.bat %base_dir%\python-gconf.py %site_dir%\gconf.py
call %tmp%\install_file.bat %base_dir%\python-pwd.py %site_dir%\pwd.py
call %tmp%\install_file.bat %base_dir%\python-termios.py %site_dir%\termios.py
call %tmp%\install_file.bat %base_dir%\python-vte.py %site_dir%\vte.py

if not exist %site_dir%\dbus mkdir %site_dir%\dbus

call %tmp%\install_file.bat %base_dir%\python-dbus-__init__.py %site_dir%\dbus\__init__.py
call %tmp%\install_file.bat %base_dir%\python-dbus-glib.py %site_dir%\dbus\glib.py
call %tmp%\install_file.bat %base_dir%\python-dbus-service.py %site_dir%\dbus\service.py
