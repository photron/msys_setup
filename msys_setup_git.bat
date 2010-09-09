if %sentinel% NEQ __sentinel__ exit

call %tmp%\wget_and_unpack1.bat http://msysgit.googlecode.com/files PortableGit-1.6.5.1-preview20091022.7z %git_dir%
echo %git_dir% /git >> %msys_dir%\etc\fstab
echo export PATH=$PATH:/git/bin > %msys_dir%\etc\profile.d\git.sh
