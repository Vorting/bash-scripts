#!/usr/bin/bash

# This bash script is used to backup a user's home directory to /tmp/.

function backup {
	
	if [ -z $1 ]; then
		user=$(whoami)
	else
		if [ ! -d "/home/$1" ]; then
			echo "Requested $1 user home directory doesn't exist."
			exit 1
		fi
		user=$1
	fi

	input=/home/$user/Downloads
	output=/tmp/${user}_home_$(date +%Y-%m-%d_%H%M%S).tar.gz
	
	function total_files {
		find $1 -type f | wc -l
	}
	# This function shows a total number of directories for specified directory
	function total_dirs {
		find $1 -type d | wc -l
	}

	function total_archived_dirs {
		tar -tzf $1 | grep /$ | wc -l
	}

	function total_archived_files {
		tar -tzf $1 | grep -v /$ | wc -l
	}
	
	tar -cvzf $output $input 2> /dev/null
	src_files=$( total_files $input )
	src_dir=$( total_dirs $input )

	arch_files=$( total_archived_files $output )
	arch_dir=$( total_archived_dirs $output )

	echo "########## $user ##########"
	echo "Files to be included: $src_files"
	echo "Directories to be included: $src_dir"
	echo "Files archived: $arch_files"
	echo "Directories archived: $arch_dir"
	
	if [ $src_files -eq $arch_files ]; then
		echo "Backup of '$input' completed!" 
        	echo "Details about the output backup file:"
        	ls -l $output
	else
        	echo "Backup of $input failed!"
	fi
}

for dir in $*; do
	backup $dir
	let all=$all+$arch_files+$arch_dir
done;
echo "TOTAL FILES AND DIRECTORIES: $all"
