#! /usr/bin/bash
list=()
sshkey=()

mykey=zzzzzz
key=()
while getopts 'u:h:l:i:k:' OPTION; do
do
    case "$OPTION" in
        u) echo "user is"
		user=${OPTION} 
		;;
       	h) echo "host is"
		host=${OPTION}
		hosts+=($host)
                ;;
        l) echo "list is"
		list=${OPTION}
		readarray -t hosts < $list
			if [ ! -f "$list" ]; then
        			echo "FIle $list dont exist"
        			exit 1
			elif [ ! -s "$list" ]; then
        			echo "File $list is empty"
				exit 2
			fi		
		;;
        k) key=${OPTION}
		;;
        i) mykey=${OPTION}
			if [ ! -f "$mykey" ]; then
				echo "File $myfile dont exist"
				exit 1
			fi
		;;
    esac
done

echo "keys $sshkey $mykey"
if [ ! -z "$mykey" ]; then
	sshkey="-i $mykey"
	echo "keys $sshkey $mykey"
fi
if [ -z "$host" ] && [ -z "$hosts" ];
then 
	echo "Specify at least one host. -h hostname or -l filename"
	exit 3
fi
if [ -z "$user" ];
then
        echo "Username is required -u xxx"
        exit 4
fi

echo $hosts
for host in "${hosts[@]}"; do
  echo $host $user $sshkey
  echo "  ${hosts[*]}"
#  << 'COMMENT'
	echo "root@$host "
	ssh $sshkey root@$host /bin/bash <<EOF
		adduser $user
			if [ -z "$key" ]; then
				
				echo "Only user has been added"
			exit 0
			else
		mkdir -p /home/$user/.ssh
		chown $user:$user /home/$user/.ssh
		chmod 711 /home/$user/.ssh
		echo `cat $key` $user >> /home/$user/.ssh/authorized_keys
		chmod 600 /home/$user/.ssh/authorized_keys
		chown $user:$user /home/$user/.ssh/authorized_keys
			#fi
exit
EOF
#COMMENT
done
#bash -c "'ssh -i $mykey root@$host adduser $name'"
