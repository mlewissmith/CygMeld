#!/bin/bash
set -e
cd=$(dirname $(readlink -e $0))
source _build_sh.rc

## NOTES
## - last buildable, runnable revision `meld@b831bb7`
##   +b831bb7eb50594a708ab4d9f0fc9ac45ca41cce3 meld (1.7.0-62-gb831bb7)
## - current "stable" version 1.8.5 is not tagged,
##   but is available as `meld@2591549`
##   +2591549e5324518fa7e096290fef8fa6dd9e8c7b meld (1.8.4-9-g2591549)

name=meld
version=1.7.0
release=20140710

BuildRequires intltool
BuildRequires python-gtk2.0
BuildRequires rarian

set -x
_sourcedir=$(dirname $(readlink -e $0))
_builddir=$(dirname $(readlink -e $0))
buildroot=${_builddir}/BUILDROOT
__setup_n=${name}-${version}

#prep
{
    __setup_n=meld
    rm -rf ${buildroot}
    cd ${_builddir}
    cd ${__setup_n}
    git clean -xdf
}


#build
{
    cd ${_builddir}
    cd ${__setup_n}
}


#install
{
    cd ${_builddir}
    cd ${__setup_n}
}
make DESTDIR=${buildroot} prefix=/opt/${name}-${version} install

mkdir -p ${buildroot}/etc/profile.d
cat <<EOF>${buildroot}/etc/profile.d/${name}-${version}.sh
export PATH=/opt/${name}-${version}/bin:\$PATH
EOF

#PACKAGE
{
    cd ${_sourcedir}
}
mkdir -p ${buildroot}/etc/uninstall
sed "s:%MANIFEST%:${name}-${version}.lst:g" _uninstaller.sh > ${buildroot}/etc/uninstall/${name}-${version}-${release}-uninstall.sh
chmod 0644 ${buildroot}/etc/uninstall/${name}-${version}-${release}-uninstall.sh

find ${buildroot} -mindepth 1 -not -type d -printf "%P\n" > ${name}-${version}.lst
find ${buildroot} -mindepth 1 -type d -printf "%P/\n" >> ${name}-${version}.lst
sort ${name}-${version}.lst >  ${buildroot}/${name}-${version}.lst

sed "s:%MANIFEST%:${name}-${version}.lst:g" _installer.sh > ${buildroot}/_installer.sh
chmod 0755 ${buildroot}/_installer.sh

makeself --bzip2 ./BUILDROOT ${name}-${version}-${release}.${MACHTYPE}.sh "${name}-${version}-${release}.${MACHTYPE}" ./_installer.sh

