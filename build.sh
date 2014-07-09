#!/bin/bash
set -e
source _build_sh.rc

## [mils] NOTE
## current stable version 1.8.5 is not tagged, but is available as git revision 2591549

name=meld
version=1.6.0
release=0.1.1

BuildRequires intltool
BuildRequires python-gtk2.0

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
    git submodule update
    cd ${__setup_n}
    git reset --hard
    git clean -xdf
}
git apply ../P001-makefile.diff


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

