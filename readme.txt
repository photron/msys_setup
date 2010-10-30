
--- Compiling libvirt using MSYS/MinGW


- make sure to have at least 1.5 GB of free disk space


- download wget.exe from http://users.ugent.be/~bpuype/wget/ and put it in
  the same directory as msys_setup.bat


- run msys_setup.bat to download and setup an MSYS/MinGW environment


- run msys\msys.bat to open a MSYS shell


- run compile_portablexdr.sh in the MSYS shell


- run compile_libxml2.sh in the MSYS shell


- if you need VMware ESX support in libvirt run compile_polarssl.sh and
  compile_libcurl.sh in the MSYS shell

  be aware that this pulls in GPL'ed PolarSSL. the previous approach used
  LGPL'ed GnuTLS for libcurl's SSL/TLS needs, but this results in this
  runtime error:

    A TLS packet with unexpected length was received

  this error seems to be a known issue, but I haven't found a fix for it yet.


- run compile_libvirt-0.8.4.sh in the MSYS shell


- done
