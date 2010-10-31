if %sentinel% NEQ __sentinel__ exit

call %tmp%\wget_and_unpack1.bat http://msysgit.googlecode.com/files PortableGit-1.7.3.1-preview20101002.7z %git_dir%
echo %git_dir% /git >> %msys_dir%\etc\fstab
echo export PATH=/git/cmd:$PATH > %msys_dir%\etc\profile.d\git.sh
