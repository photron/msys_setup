if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/glib/2.24
call %tmp%\wget_and_unpack1.bat %gnome_url% glib_2.24.0-2_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% glib-dev_2.24.0-2_win32.zip %msys_dir%
