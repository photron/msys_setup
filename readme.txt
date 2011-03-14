
--- Is this what you're looking for?

- if you want a prebuilt Windows installer for libvirt, rather than compiling
  yourself, take a look at http://libvirt.org/windows.html





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


- run compile_libvirt-0.8.8.sh in the MSYS shell


- run gather_libvirt.sh in the MSYS shell


- you can find all necessary files in msys\gather\libvirt now


- done





--- Setting up virt-manager using MSYS/MinGW


- the next steps assume that you have setup the MSYS/MinGW environment and
  compiled libvirt as in it the steps described above


- run msys\msys.bat to open a MSYS shell if you don't have it open anymore


- if you didn't run compile_libcurl.sh in the MSYS shell for VMware ESX
  support run it now, because it is an indirect dependency of virt-manager


- run compile_pycurl.sh in the MSYS shell


- run compile_urlgrabber.sh in the MSYS shell


- run compile_virt-install.sh in the MSYS shell


- run compile_gtk-vnc.sh in the MSYS shell


- run compile_virt-manager.sh in the MSYS shell


- you can now start virt-manager from the MSYS shell. as it can't store it's
  configuration in a persistent way currently (due to the lack of a proper
  gconf implementation), you'll need to specify the connection URI on every
  start like this:

  virt-manager --no-dbus --no-fork --connect qemu://<remote>/system
