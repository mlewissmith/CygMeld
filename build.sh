#!/bin/bash
set -e -x
umask 0022

NAME=meld
VERSION=1.6.0
BUILDDIR=$(dirname $(readlink -e $0))
BUILDROOT=${BUILDDIR}/BUILDROOT

#prep
rm -fr ${BUILDROOT}
cd ${BUILDDIR}/meld
#git clean -xdf


#build
cd ${BUILDDIR}/meld
make configure
./configure --prefix=/opt/${NAME}-${VERSION}
make all

#install
cd ${BUILDDIR}/meld
make DESTDIR=${BUILDROOT} install

#package
cd ${BUILDROOT}
tar -jcvf ${BUILDDIR}/${NAME}-${VERSION}.tar.bz2 *
