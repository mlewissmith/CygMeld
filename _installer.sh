#!/bin/bash
set -e
umask 0022

MANIFEST=%MANIFEST%

if [[ "${OSTYPE}" != "cygwin" ]] ; then
    echo "[FATAL] $OSTYPE: not cygwin"
    exit 1
fi

## assume /etc/setup/*.lst.gz
zcat /etc/setup/*.lst.gz | sort -u > _installed.lst

conflict=0;
for file in $(<${MANIFEST}) ; do
    if egrep -q "^${file}$" _installed.lst ; then
        if [ -d ${file} ] ; then
            true
        else
            echo "[FATAL] $file: **CONFLICT** file exists"
            ((conflict++))
        fi
    fi
done

[[ $conflict -eq 0 ]] || exit 1

## Verification OK.  Install...
for file in $(<${MANIFEST}) ; do
    echo "${file}"
    if [[ -d $file ]] ; then
        if [[ ! -e /${file} ]] ; then
            mkdir -v /${file}
        fi
    else
        cp -v ${file} /${file}
    fi
done
gzip -c ${MANIFEST} > /etc/setup/${MANIFEST}.gz
