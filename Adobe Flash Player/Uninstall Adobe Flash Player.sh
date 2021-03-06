#!/bin/bash
# Uninstall Adobe Flash Player.sh
# Author - Encore Technologies
# Author - Tyler Sparr
# This script will completely uninstall Adobe Flash and all supporting components

# This script is provided without warranty or guarantee, and is licensed for use only at the direction of Encore Technologies.
# It is not for distribution. Any application of this script at a customer location is allowed; however,
# use of this script by Encore Technologies or customers of Encore Technologies does not make Encore Technologies
# responsible for any ongoing maintenance of this script.

# Copyright © 2016 Encore Technologies

dmgfile="uninstall_flash_player_osx.dmg"
volname="Flash"
logfile="/Library/Logs/FlashRemovalScript.log"

url="https://fpdownload.macromedia.com/get/flashplayer/current/support/uninstall_flash_player_osx.dmg"


    currentinstalledver=`/usr/bin/defaults read "/Library/Internet Plug-Ins/Flash Player.plugin/Contents/version" CFBundleShortVersionString`
    if [ "${currentinstalledver}" ]; then
        /bin/echo "`date`: Downloading uninstaller." >> ${logfile}
        /usr/bin/curl -s -o /tmp/$dmgfile $url
        /bin/echo "`date`: Mounting uninstaller disk image." >> ${logfile}
        /usr/bin/hdiutil attach /tmp/$dmgfile -nobrowse -quiet
        /bin/echo "`date`: Uninstalling..." >> ${logfile}
        /Volumes/Flash\ Player/Adobe\ Flash\ Player\ Uninstaller.app/Contents/MacOS/Adobe\ Flash\ Player\ Install\ Manager -uninstall> /dev/null
        /bin/sleep 10
        /bin/echo "`date`: Unmounting uninstaller disk image." >> ${logfile}
        /usr/bin/hdiutil detach $(/bin/df | /usr/bin/grep ${volname} | awk '{print $1}') -quiet
        /bin/sleep 10
        /bin/echo "`date`: Deleting disk image." >> ${logfile}
        /bin/rm /tmp/${dmgfile}
    else
        /bin/echo "`date`: Flash is not installed" >> ${logfile}
        /bin/echo "--" >> ${logfile}
    fi
