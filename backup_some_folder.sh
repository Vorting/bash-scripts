#!/bin/bash

TIME=`date +"%Y%m%d-%H%M"`
FILENAME=currentFolder-$TIME.zip
SRCDIR=/home/vorting/currentFolder
DESDIR=/home/backup

zip -r $DESDIR/$FILENAME $SRCDIR

