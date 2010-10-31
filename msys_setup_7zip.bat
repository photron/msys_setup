if %sentinel% NEQ __sentinel__ exit

set msi=7z465.msi
set zip_url=http://downloads.sourceforge.net/sevenzip

if exist %zip% goto have_zip
if exist %tmp%\%msi% goto unpack_zip
echo downloading %msi% ...
%wget% %zip_url%/%msi% -O %tmp%\%msi%
:unpack_zip
echo unpacking %msi% ...
msiexec /a %tmp%\%msi% TARGETDIR=%base_dir%\7z /qb
:have_zip
