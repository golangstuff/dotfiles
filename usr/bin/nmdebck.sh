#!/bin/sh
# Author: Aron Xu <happyaron.xu@gmail.com>
# Description: 
#  Shell script to print the Version from a Debian binary package, and find if
#  the copyright file is at correct place in the package.
# License: GPL-3+
# Last Change: 2011-02-17

# Directories
CURDIR=`pwd`
TMPDIR=${CURDIR}/tmp
DEBFILE=`basename $1`
DEBBASE=`basename $1 | sed -r 's/([^_]*).*/\1/'`

# Test if the .deb archive exist as a normal file. If not, abort with a
# message.
if [ ! -f $1 ]; then
    printf "The specified location does not exist or appears to be not a normal file, abort.\n";
    exit;
elif [ -n "`file $1|grep -q "Debian binary package"`" ]; then
    printf "The given file is not a Debian binary package, abort.\n";
    exit;
elif [ -e ${TMPDIR} ]; then
    printf "The temp directory ./tmp already exsit, abort.\n";
    exit;
else
    mkdir ${TMPDIR};
fi

# Use symbolic link rather than cp or hard linking, because symbolic link is enough and
# much faster.
cd ${TMPDIR}; ln -s ../${1} .;

# Extract the archive with ar. It might take some time if the file is huge,
# but we do need to do so for I have to use both of the two .tar.gz files, the
ar -x ${DEBFILE};

# Extract control file from control.tar.gz, we do not need other files in it.
tar -zxf ./control.tar.gz ./control;

# Find the version number and print it out, don't print things like
# 'Python-Version'. --color=never might break on some old coreutils, but it
# has to be there on newer ones in case of errors.
printf "The Version string is:\n";
cat control | grep --color=never 'Version:' | grep --color=never -v -- '-V' |   sed 's/Version: //';

# Find where is the copyright file, we don't need
FROMARC=`tar -ztf data.tar.gz | grep --color=never copyright`
EXPECTED=./usr/share/doc/${DEBBASE}/copyright
if [ "${FROMARC}" = "${EXPECTED}" ]; then
    printf "Copyright file location correct, at:\n${FROMARC}\n";
else
    printf "Copyright file location incorrect, at:\n${FROMARC}\nExpected:       \n${EXPECTED}\n";
fi

# Remove temp directory created by the script.
cd ${CURDIR}; rm -rf ${TMPDIR};
