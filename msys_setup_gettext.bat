if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies

call %tmp%\wget_and_unpack1.bat %gnome_url% gettext-runtime_0.18.1.1-2_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% gettext-runtime-dev_0.18.1.1-2_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% gettext-tools-dev_0.18.1.1-2_win32.zip %msys_dir%
