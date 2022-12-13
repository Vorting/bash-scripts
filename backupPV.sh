#!/usr/bin/env bash

TIME=`date +"%Y%m%d-%H%M"`
FILENAME=backup-$TIME
SRCDIR=/home/dmytro
DESDIR=/backup

# Query dpkg to get the version of the currently installed pv package.
# The command returns false if the package is not installed.
if version=$(dpkg-query -W -f='${Version}' pv 2>/dev/null); then 

    # Check if it's older than 1.5
    if dpkg --compare-versions "$version" '<' 1.1.5; then
       sudo apt remove pv || exit
    else
        printf 'Looks good.\n. \nLet`s make backup.\n'
	tar -czf - "$SRCDIR" | pv -s $(du -sb | grep -o '[0-9]*') > $DESDIR/$FILENAME.tgz
        exit
    fi
fi

echo "installing pv"
sudo apt-get update &&
sudo apt-get install pv
