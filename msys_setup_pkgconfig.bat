if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% pkg-config_0.23-3_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% pkg-config-dev_0.23-3_win32.zip %msys_dir%
