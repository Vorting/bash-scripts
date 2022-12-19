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
listUrlResult=list№2.help.javarush.ru.csv # output file

# Creates text files for storing results
#echo " Creating files"
#> existUrl_$listUrlResult
#> noExistUrl_$listUrlResult

menu () {
while true ; do
  clear
  echo "1: Run check"
  echo "2: Show pattern"
  echo "3: Exit"
  read -r -sn1
  case "$REPLY" in
    1)get_url;;
    2)show_pattern;;
    3)exit 0;;
  esac
  read -r -n1 -p "Press any key"
done
}

create_dir () {
message="Please enter dir name"
declare -l DIR
echo "$message. The dir will creates in $PWD"
read -r DIR
if [[ -e "$DIR" ]]
    then
      echo "${DIR} already exists. Please re-run the $0"
      exit 1
     # menu
   else
    if [[ -w "$PWD" ]] 
    then
    echo "###Creating $DIR in $home_dir###"
     mkdir -p "$DIR" && cd "$DIR" || return $?
    else 
      echo "You don't have permissionss to $PWD"
      exit 2

    fi
fi
}
show_pattern () {

array=$(cat "$patternUrlLocation" ) 
for item in "${array[@]}"; do
    echo "${item}"
done
}

get_url () {
   create_dir
   # Use IFS to separate ours listOfUrls as a url
	 while IFS= read -r "url"	 # echo "Recursive url checking"
    pattern_url=$(show_pattern)
	 do
	   redirectCount=0
	   response=$(curl -sL -Iw "%{http_code}" "$url")
     http_code=$(tail -n1 <<< "$response")  # get the last line
     content=$(sed '$ d' <<< "$response")   # get all but the last line which contains the status code
     url_content=$(sed -n -e 's/^.*ocation: //p' <<< "$content")
     echo "###Getting http-code $url ###"
     blue="\033[34m"
     green="\033[92m"

     if [[ $http_code =~ ^2:500 ]]; then
       if [[ $http_code -eq 200 && "$pattern_url" == "$url_content" ]]; then 
            printf "\u00A9 %s\n ${url} Status: $http_code. No redirects. A url ${url_content} matches ${url_content} " | paste -sd ',' >> "./existUrl_$listUrlResult"
       fi
       elif [[ $http_code -eq 301 || $http_code -eq 200 ]]; then
            let redirectCount+=1
            printf "\u00A9 %b\n ${url} Status: #301 & #200. Number of #301 redirects: $redirectCount. A url ${url_content} matches ${url_content} \r" | paste -sd ',' >> "./existUrl_$listUrlResult"
       elif [[ $http_code -eq 403 ]]; then
            printf "\u00A9 %s\n ${url} Status: #403 Forbidden" | paste -sd ',' >> "./noExistUrl_$listUrlResult"
      
       elif [[ ($http_code -eq 301 && $http_code -eq 404) || ! ($http_code -ne 404) ]]; then
            printf "\u00A9 %s\n ${url} Status: #404 Forbidden" | paste -sd ',' >> "./noExistUrl_$listUrlResult"
     else
         #echo "${url} ERROR: Server returned HTTP code $http_code" >> "./noExistUrl_$listUrlResult"
          exit 1
       fi
done  < "$listUrlLocation"
}
menu
