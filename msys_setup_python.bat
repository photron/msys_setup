if %sentinel% NEQ __sentinel__ exit

set msi=python-2.6.6.msi
set python_url=http://python.org/ftp/python/2.6.6
if exist %python_dir%\python.exe goto have_python
if exist %tmp%\%msi% goto unpack_python
echo downloading %msi% ...
%wget% %python_url%/%msi% -O %tmp%\%msi%
:unpack_python
echo unpacking %msi% ...
msiexec /a %tmp%\%msi% TARGETDIR=%python_dir% /qn
:have_python


if not exist %python_dir%\include\python2.6 mkdir %python_dir%\include\python2.6
dir /b %python_dir%\include\*.h > %tmp%\python2.6_headers.txt
for /f %%F in (%tmp%\python2.6_headers.txt) do call %tmp%\install_file_silent.bat %python_dir%\include\%%F %python_dir%\include\python2.6\%%F



call %tmp%\install_file.bat %base_dir%\python-config    %msys_dir%\bin\python-config
call %tmp%\install_file.bat %base_dir%\python-config    %msys_dir%\bin\python2.6-config
call %tmp%\install_file.bat %base_dir%\python-config.py %msys_dir%\bin\python-config.py

call %tmp%\install_file.bat %base_dir%\patch_python.sh %msys_dir%\bin\patch_python.sh
call %tmp%\install_file.bat %base_dir%\python-2.6.6-sysconfig.patch %msys_dir%\src\python-2.6.6-sysconfig.patch



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
echo *) echo error: too many arguments for python wrapper script            >> %msys_dir%\bin\python
echo esac                                                                   >> %msys_dir%\bin\python

%msys_dir%\bin\sh.exe -ec patch_python.sh


echo export PATH=$PATH:/python/Lib/site-packages >  %msys_dir%\etc\profile.d\python.sh
