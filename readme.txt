
--- Compiling libvirt using MSYS/MinGW


- make sure to have at least 1.5 GB of free disk space


- download wget.exe from http://users.ugent.be/~bpuype/wget/ and put it in
  the same directory as msys_setup.bat


- run msys_setup.bat to download and setup an MSYS/MinGW environment

  you'll see automated Windows Installer popups for 7zip and Python. the
  script is not actually installing something to your system, it just unpacks
  both into subdirectories for later use.

  when you have UAC enabled (Windows Vista and Windows 7) then Windows will
  ask you for confirmation, you need to allow 7zip and Python to get unpacked


- run msys\msys.bat to open a MSYS shell


- run compile_portablexdr.sh in the MSYS shell


- run compile_libxml2.sh in the MSYS shell


- if you need VMware ESX support run compile_libcurl.sh in the MSYS shell


- run compile_libvirt-0.8.6.sh in the MSYS shell


- run gather_libvirt.sh in the MSYS shell


- you can find all necessary files in msys\gather\libvirt now


- done
