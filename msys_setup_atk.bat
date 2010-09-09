if %sentinel% NEQ __sentinel__ exit

set gnome_url=http://ftp.gnome.org/pub/gnome/binaries/win32/atk/1.30
call %tmp%\wget_and_unpack1.bat %gnome_url% atk_1.30.0-1_win32.zip %msys_dir%
call %tmp%\wget_and_unpack1.bat %gnome_url% atk-dev_1.30.0-1_win32.zip %msys_dir%
