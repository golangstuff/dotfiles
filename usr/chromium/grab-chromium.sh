#!/bin/sh
# Shell script to grab specific build from build.chromium.org
# Copyright (C) 2010 Aron Xu <happyaron.xu@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Place you would like to install chromium.
PLACE=${HOME}/usr/chromium

# Temp directory for downloading files.
TMPDIR=/dev/shm/chromium-update

# Downloader and options, please ONLY left ONE of all listed below uncommented.
# Use wget, default.
#DOWN="wget -P ${TMPDIR}"
# Use aria2, if you like.
DOWN="aria2c -x 5 -d ${TMPDIR}"
# Use curl, if you prefer curl to wget.
#DOWN="cd ${TMPDIR};curl -O"
# Use axel, it's an old buggy thing... Okay, if you still like it, I give in.
#DOWN="axel -o ${TMPDIR}"

# Process name
PROCESS=chrome
# Don't change it if you don't know what you are doing.
# Command line, for grabbing a specific version.
LATEST=$1
# i386
#LATEST=`wget -q -O - 'http://build.chromium.org/buildbot/snapshots/chromium-rel-linux/LATEST' | awk 'NF > 0'`
# amd64
#LATEST=`wget -q -O - 'http://build.chromium.org/buildbot/snapshots/chromium-rel-linux/LATEST' | awk 'NF > 0'`

# Script actually starts from here.

CURDIR=`pwd`
if [ -f ${PLACE}/CURRENT ]; then
	CURRENT=`cat ${PLACE}/CURRENT`
	if [ $LATEST -le $CURRENT ]; then
		exit;
	fi
fi

if [ -f ${PLACE}/OLD ]; then
	OLD=`cat ${PLACE}/OLD`;
fi

if [ -d ${TMPDIR} ]; then
	rm -rf ${TMPDIR}/* && cd ${TMPDIR};
else
	rm -rf ${TMPDIR} && mkdir ${TMPDIR} && cd ${TMPDIR};
fi

${DOWN} http://build.chromium.org/f/chromium/snapshots/chromium-rel-linux/$LATEST/chrome-linux.zip

#${DOWN} http://184.82.250.59/~aron/chrome-linux.zip

cd ${TMPDIR}
unzip ${TMPDIR}/chrome-linux.zip
rm -f ${TMPDIR}/chrome-linux.zip

mkdir ${PLACE}/${LATEST}
mv ${TMPDIR}/chrome-linux/* ${PLACE}/${LATEST}/
rm -rf ${TMPDIR}

rm -f ${PLACE}/chromium-browser
ln -s ${PLACE}/$LATEST ${PLACE}/chromium-browser

rm -rf ${PLACE}/${OLD}
mv ${PLACE}/CURRENT ${PLACE}/OLD
if [ -f ${PLACE}/OLD ]; then
	OLD=`cat ${PLACE}/OLD`;
fi

if ps -U ${USER} | grep -v grep | grep ${PROCESS} > /dev/null ; then
	printf "Chromium is running, not removing previously installed version.\n"
else
	printf "Chromium is not running, removing previously installed version.\n"
	rm -rf ${PLACE}/${OLD}
fi

echo $LATEST > ${PLACE}/CURRENT
echo $LATEST > ${PLACE}/GRAB

