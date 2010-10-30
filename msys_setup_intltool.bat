if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.acc.umu.se/pub/GNOME/binaries/win32/intltool/0.40
call %tmp%\wget_and_unpack1.bat %gnome_url% intltool_0.40.4-1_win32.zip %msys_dir%


call %tmp%\install_file.bat %base_dir%\patch_intltool.sh %msys_dir%\bin\patch_intltool.sh
call %tmp%\install_patch.bat intltool-0.40-perl.patch

%msys_dir%\bin\sh.exe -ec patch_intltool.sh
