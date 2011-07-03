
--- Setting up virt-manager


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
