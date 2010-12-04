if %sentinel% NEQ __sentinel__ exit

call %tmp%\wget_and_install.bat http://downloads.sourceforge.net/sevenzip 7z465.msi %base_dir%\7z
