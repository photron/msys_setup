if %sentinel% NEQ __sentinel__ exit

set msi=python-2.6.5.msi
set python_url=http://python.org/ftp/python/2.6.5
if exist %python_dir%\python.exe goto have_python
if exist %tmp%\%msi% goto unpack_python
echo downloading %msi% ...
%wget% %python_url%/%msi% -O %tmp%\%msi%
:unpack_python
echo unpacking %msi% ...
msiexec /a %tmp%\%msi% TARGETDIR=%python_dir% /qn
:have_python
