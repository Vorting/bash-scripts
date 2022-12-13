#!/bin/bash

home_dir=$USER
listUrlLocation=/home/$home_dir/list.borken.url.txt

# Use IFS to separate ours listOfUrls as a url 
# set -x # uncoment to start debugging

while IFS= read -r url
# echo "Recursive url checking"
do
#set -x
currentUrl=$url
response=$(curl -sL -Iw "%{http_code}" $url)

echo "##########original_URL###########: $currentUrl"
http_code=$(tail -n1 <<< "$response")  # get the last line
content=$(sed '$ d' <<< "$response")   # get all but the last line which contains the status code

echo "$http_code"
echo "$content"

# set +x # uncoment to off debugging

done  < $listUrlLocation