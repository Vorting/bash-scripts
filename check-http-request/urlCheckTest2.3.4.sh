#!/bin/bash -x
## "&&" 1s command always executes, 2nd will execute if 1st finish successful.
## "||" 1st command always executes, 2nd command will execute if 1st fails
## "-x|+x" un/comment these lines to start/stop debugging
## listUrlLocation set path to your list of urls
## listUrlResult give name to output result file
## patternUrlLocation list of pattern-urls

home_dir=$(whoami)
patternUrlLocation=/home/${home_dir}/list_pattern_urls.txt
listUrlLocation=/home/${home_dir}/list_of_urls2.txt # path to ours file
listUrlResult="list.javarush.csv" # output file

menu () {
while true ; do
  clear
  echo "Check url's http-code"
  echo "1: Run check"
  echo "2: Show pattern (works only in debug mode)"
  echo "3: Exit"
  read -sn1
  case "$REPLY" in
    1)get_url;;
    2)show_pattern;;
    3)exit 0;;
  esac
  read -n1 -p "Press any key"
done
}

create_dir () {
message="Please enter dir name"
declare -l DIR
echo "Enter dir name. The dir will creates in $PWD/$DIR"
read DIR
if [[ -e $DIR ]]
    then
      echo "${DIR} already exists. Please re-run the $0"
      exit 1
   else
    if [[ -w $PWD ]] 
    then
    echo "###Creating $DIR in $PWD ###"
     mkdir -p $DIR && cd $DIR
    else 
      echo "You don't have permissionss to $PWD"
      exit 2
    fi
fi
}

show_pattern () {
for i in $(cat $patternUrlLocation ) ; do
     tmp=${i}
     #echo "$tmp"
done < ${patternUrlLocation}
}

get_url () {
   create_dir
   # Use IFS to separate ours listOfUrls as a url
	 while IFS= read -r "url"	 # echo "Recursive url checking"
    pattern_url="$(show_pattern)"
	 do
	 redirectCount=0
	 response=$(curl -sL -Iw "%{http_code}" "$url")
     	 http_code=$(tail -n1 <<< "$response")  # get the last line
     	 content=$(sed '$ d' <<< "$response")   # get all but the last line which contains the status code
         url_content=$(sed -n -e 's/^.*Location: //p' <<< "$content")
#     expiry_date=`$response | egrep -i "Expiration Date:|Expires on"| head -1 | awk '{print $NF}'`
      echo "###Getting http-code $url ###"

     if [[ $http_code =~ ^2:500 ]]; then
       if [[ $http_code -eq 200 && "$pattern_url" == "$url_content" ]]; then 
            echo "${url} Status: #200. No redirects. A url ${url_content} matches ${url_content} " >> "./existUrl_$listUrlResult"
       fi
       elif [[ $http_code -eq 301 || $http_code -eq 200 ]]; then
            let redirectCount+=1
            echo  "${url} Status: #301 & #200. Number of #301 redirects: $redirectCount. A url ${url_content} matches ${url_content}"  >> "./existUrl_$listUrlResult"
       elif [[ $http_code -eq 403 ]]; then
            echo "${url} Status: #403 Forbidden " >> "./noExistUrl_$listUrlResult"
       elif [[ ($http_code -eq 301 && $http_code -eq 404) || ($http_code -eq 404 && $http_code -eq 404) ]]; then
            echo "${url} Status:#301 & #404 particulary works" >> "./noExistUrl_$listUrlResult"
     else 
          echo "${url} Status: $http_code Not Found" >> "./noExistUrl_$listUrlResult"
          exit 1
       fi
done  < $listUrlLocation
}
menu
