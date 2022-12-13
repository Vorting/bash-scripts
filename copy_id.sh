#! /usr/bin/bash
list=()
sshkey=()
#while [[ $# -gt 0 ]]; do
#  case $1 in
#    -u|--user)
#      user="$2"
#      shift
#      shift
#      ;;
#    -k|--key)
#      key="$2"
#      shift
#      ;;
#    -l|--list)
#      list="$2"
#      if [ ! -f "$list" ]; then
#    echo "File $list does not exist!"
#    	exit
#elif [ ! -s "$list"]; then
#	echo "File $list empty!"
#        exit
#      fi
#		readarray -t list < $list
#      shift
#      ;;
#    -i|--mykey)
#      mykey="-i $2"
#      shift
#      ;;
#    -h|--host)
#      host="$2"
#	      list+=($host)
#      shift
#      shift
#      ;;
#    -*|--*)
#      echo "Unknown option $1"
#
#      exit 1
#      ;;
#    *)
#	    echo "Use sintax for this script  -h ostname or -l filename, -u Username (required fields), -l filename -k "Remote publickey", -i "your privatkey"  "
#      shift
#      ;;
#  esac
#done
mykey=zzzzzz
key=()
while getopts u:h:l:i:k: flag
do
    case "${flag}" in
        u) user=${OPTARG};;
	        h) host=${OPTARG}

                hosts+=($host)
                ;;
        l) list=${OPTARG}
		readarray -t hosts < $list
			if [ ! -f "$list" ]; then
        			echo "FIle $list dont exist"
        			exit
			elif [ ! -s "$list" ]; then
        			echo "File $list is empty"
			fi		
		;;
        k) key=${OPTARG}
		;;
        i) mykey=${OPTARG}
			if [ ! -f "$mykey" ]; then
				echo "File $myfile dont exist"
				exit
			fi
		;;
    esac
done
#readarray -t list < $list
#list+=($host)i

#		readarray -t list < $list
#if [ ! -f "$mykey" ]; then
#	echo "File $mykey dont exist"
#		exit
#	elif 
echo "keys $sshkey $mykey"
if [ ! -z "$mykey" ]; then
	sshkey="-i $mykey"
	echo "keys $sshkey $mykey"
fi
if [ -z "$host" ] && [ -z "$hosts" ];
then 
	echo "Specify at least one host. -h hostname or -l filename"
	exit
fi
if [ -z "$user" ];
then
        echo "Username is required -u xxx"
        exit
fi
#sshkey="-i $mykey"

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
			exit
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
