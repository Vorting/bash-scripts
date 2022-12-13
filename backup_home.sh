#!/bin/bash

TIME=`date +"%Y%m%d-%H%M"`
FILENAME=backup-home-$USER-$TIME.tgz
DESDIR=/tmp/backups

tar -czf - . | pv -s $(du -sb | grep -o '[0-9]*') > $DESDIR/$FILENAME
