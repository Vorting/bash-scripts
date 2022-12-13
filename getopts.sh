#!/bin/bash


if [ $# -lt 1 ]
then
	echo "No options found!"
	exit 1
fi

while getopts "a:b" opt
do
	case $opt in 
		a) echo "Found option $opt"
			echo "Found argument for option $opt - $OPTARG"
			;;
		b) echo "Found option $opt";;
		*) echo "Nop reasonable options found!";;
	esac
done
