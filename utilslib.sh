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
