if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% cairo_1.8.10-3_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% cairo-dev_1.8.10-3_win32.zip %msys_dir
