if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% libpng_1.4.0-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% libpng-dev_1.4.0-1_win32.zip %msys_dir%
