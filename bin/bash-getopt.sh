#! /bin/bash

# bash-getopt.sh
# Author : Austin Burt
# Email  : austin@burt.us.com
# Date   : 05-03-2022
# 
# A succesful command would look like :
# 
#     $PROGRAM -a -l link -m message -s second

[[ -z $PROGRAM ]] && declare -r PROGRAM=$(basename $0)

USAGE() { echo "$0 USAGE:" && grep " .)\ \#" $0; exit 0; exit; }

GO=":hl:as:m:" 

echo "Welcome! This is an example for getopts."
echo "The inputs are: "
echo -e "\tgetopts='$GO'"
echo -e "\tARGS='$@'\n"
echo -e "              :: OPTIND :: OPTARG"

PRINTOPTS() {
  echo -n "opt value '$1'"
  echo " :: $OPTIND :: $OPTARG"
}

while getopts "$GO" arg; do
  case $arg in
    l) # single argument required
      PRINTOPTS l
      ;;
    m) # change speed in minutes, default: 30
      PRINTOPTS m
      ;;
    a) # change speed in minutes, default: 30
      PRINTOPTS a
      ;;
    s) # change speed in seconds, default: 0
      PRINTOPTS s
      ;;
    h | *) # print usage
      USAGE ; exit ;;
  esac
done

echo -e "END OF OPTS\n"
i=1
while [[ $# -gt 0 ]]
do
  echo positional arg $((i++)): $1
  shift
done

exit 0
