#!/bin/bash

# This script checks folder name, switching to this directory & delete it's contents if directory is exist.

dir_name1="/home" # type dir_name1 here
dir_name2="/" # type dir_name2 here
# remove_dir="user2" # if you want to dele specify folder uncomment this line to remove it
 
echo "preparing to delete files" >&2
if [[ -d "$dir_name1" ]]; then
        if cd "$dir_name1"; then
        if [[ -d "$dir_name2" ]]; then
                if cd "$dir_name2"; then
                echo "deleting files in '$dir_name1$dir_name2'" >&2
                echo "deleting dir $remove_dir"
                rm -rf $remove_dir
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
echo "files deletion complete" >&2

