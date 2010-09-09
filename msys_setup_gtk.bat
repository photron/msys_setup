if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/gtk+/2.20
call %tmp%\wget_and_unpack1.bat %gnome_url% gtk+_2.20.0-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% gtk+-dev_2.20.0-1_win32.zip %msys_dir%
