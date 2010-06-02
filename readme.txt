
--- Compiling libvirt using MSYS/MinGW


- make sure to have at least 1.5 GB of free disk space


- download wget.exe from http://users.ugent.be/~bpuype/wget/ and put it in
  the same directory as setup_msys.bat


- run msys_setup.bat to download and setup an MSYS/MinGW environment.

  you're going to see dialogs about 7-Zip and Python being "installed",
  this is expected. the setup script extracts 7-Zip and Python into a local
  directory. this doesn't affect the reset of your system


- run msys\msys.bat to open a MSYS shell


- run compile_portablexdr.sh in the MSYS shell


- run compile_libxml2.sh in the MSYS shell


- if you need VMware ESX support in libvirt run compile_libcurl.sh in the
  MSYS shell


- run compile_libvirt-0.8.1.sh in the MSYS shell


- done
