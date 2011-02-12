if %sentinel% NEQ __sentinel__ exit

call %tmp%\wget_and_install.bat http://downloads.sourceforge.net/sevenzip 7z920.msi %base_dir%\7z
