#!/bin/bash

# This script checks folder name, switching to this directory & delete it's contents if directory is exist.

dir_name1="unity.site"
dir_name2="book-buffett"

echo "preparing to delete files" >&2
if [[ -d "$dir_name1" ]]; then
        if cd "$dir_name1"; then
	if [[ -d "$dir_name2" ]]; then
		if cd "$dir_name2"; then
		echo "deleting files in '$dir_name1\\$dir_name2'" >&2
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
