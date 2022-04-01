#!/bin/bash
#R3-S7S
url=$1
typeScan=$2
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
BGYELLOW="\\e[0;43m"
ENDCOLOR="\e[0m"

if [ -z $url ];then
echo -e "${RED}Missing argument: Enter website!${ENDCOLOR}"
echo "Example -> bash sub_detector.sh yahoo.com {number of type Scanning}"
echo "select type Scanner ports {1->quick scan | 2-> frist 1000 ports | 3-> aggressive}"
exit
else
echo -e "${BLUE}author:R3||S7S${ENDCOLOR}"
if [ ! -d $url ];then
mkdir $url
cd $url
else
cd $url
fi
fi
assetfinder $url > subs.txt
c=0
for sub in `cat subs.txt`
do
if [[ `ping -c 1 $sub 2> /dev/null` ]]
then
echo -e "${GREEN}${sub} +++++++++++> pong${ENDCOLOR}"
if [ ! -z $typeScan ];then
if [[ $typeScan == 1 ]];then
mkdir $sub
cd $sub
nmap -T4 $sub | tee -a $sub.txt
cd ..
elif [[ $typeScan ==  2 ]];then
mkdir $sub
cd $sub
nmap $sub | tee -a $sub.txt
cd ..
elif [[ $typeScan == 3 ]];then
mkdir $sub
cd $sub
nmap -sV $sub  | tee -a $sub.txt
cd ..
fi
else
echo -e "${RED}You have not selected type scanning!!!${ENDCOLOR}"
fi
(( c++ ))
else
echo -e "${RED}$sub -----------> error/down${ENDCOLOR}"
 (( c++ ))
fi
done
echo -e "${GREEN}\nnumber of subdomain is $c${ENDCOLOR}"
echo -e "\n${BLUE}github: https://github.com/ELHussein565\ntwitter: https://twitter.com/elhusseinsalah${ENDCOLOR}"