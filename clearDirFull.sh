#!/bin/bash

# This script checks folder name, then switching to this directory & delete it's contents if directory is existing.

dir_name1="Pictures"
dir_name2="Screenshots"

echo "preparing to deleting files" >&2

cd $PWD

if [[ -d "$dir_name1" ]]; then
	echo "Nice, the dir $dir_name1 exists. Changing directory"
        if cd "$dir_name1"; then
	if [[ -d "$dir_name2" ]]; then
		echo "The dir $dir_name2 also exists. Entering in its. "
		if cd "$dir_name2"; then
		echo "deleting files in '$dir_name1 $dir_name2'" >&2
		rm -rf *
		fi
	elif [[ !( -d "$dir_name2" ) ]]; then
		echo "no such directory: '$dir_name2'" >&2
		exit 1
	fi
else
	echo "Cannot cd to '$dir_name1'" >&2
	exit 1 
	fi
else
	echo "No such directory: '$dir_name1'" >&2
        exit 1
fi
echo "file deletion complete" >&2

echo "Viewing its content $dir_name1/$dir_name2"
ls -lah "$PWD"
