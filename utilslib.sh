#/bin/sh -ex

utilslib_download()
{
    baseurl=$1
    tarball=$2

    if [ -f ${tarball}.part ]
    then
        rm -f ${tarball}.part
    fi

    if [ ! -f ${tarball} ]
    then
        echo downloading ${tarball} ...
        wget ${baseurl}/${tarball} -O ${tarball}.part && \
        mv ${tarball}.part ${tarball}
    fi
}

prepare_dest=/gather/libvirt-prepare
prepare_bin=$prepare_dest/bin
prepare_lib=$prepare_dest/lib
prepare_include=$prepare_dest/include
prepare_python=$prepare_dest/python
prepare_src=$prepare_dest/src

mkdir -p $prepare_bin
mkdir -p $prepare_lib
mkdir -p $prepare_include
mkdir -p $prepare_python
mkdir -p $prepare_src
