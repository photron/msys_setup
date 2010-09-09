if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies
call %tmp%\wget_and_unpack1.bat %gnome_url% expat_2.0.1-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% expat-dev_2.0.1-1_win32.zip %msys_dir%
