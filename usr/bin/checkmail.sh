#!/bin/sh
# vim:fdm=marker
#Author: Aron Xu (happyaron.xu@gmail.com)
#Description: 
#Last Change: 

maildir=/home/aron/mail
mailbox=${maildir}/inbox

echo "`date +%x_%X`: I start running now!" >> runlog

getmail

for amail in `ls ${mailbox}/new/`; do
    msmtp cnfavor@126.com < ${mailbox}/new/${amail};
    if [ "$?" -ne "0" ]; then
        echo "`date +%x_%X`: ERROR sending ${amail}, Quiting!" >> errorlog;
        exit 1;
    fi
    echo "`date +%x_%X`: SENT: ${amail}." >> sentlog;
    mv ${mailbox}/new/${amail} ${mailbox}/cur/;
    sleep 1;
done
