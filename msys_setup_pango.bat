if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/pango/1.28
call %tmp%\wget_and_unpack1.bat %gnome_url% pango_1.28.0-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% pango-dev_1.28.0-1_win32.zip %msys_dir%
