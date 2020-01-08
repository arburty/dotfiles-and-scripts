#! /bin/bash

declare -r PROGRAM=$(basename $0)
path=$(pwd)

if [[ ! -z $1 ]]
then
    if [[ -d $1 ]]
    then
        path=$1
    else
        echo "$1 is not a directory"
        echo "example:" >&2
        echo -e "\t$PROGRAM" >&2
        echo -e "\t$PROGRAM <directory path>" >&2
    fi
fi

dashes() {
    str=" "
    totalLength=30
    num=$(echo -n $1 | wc -c | tr -d '[:blank:]')
    let num="30-$num-8"
    for (( i=0; i<=$num; i++ ))
    do
        str+="-"
    done
    echo "$str"
}

search=""
[[ ! -z $2 ]] && search=$2

cd $path
while read dir
do
    if [[ -d $dir ]]
    then
        echo "------- $dir""$(dashes $dir)"
        cd $dir
        git status -s 2>/dev/null
        if [[ ! -z $search ]]
        then
            git names 2>/dev/null | grep $search
        else
            git names 2>/dev/null
        fi
        cd - > /dev/null
    fi
done < <(ls)

    exit 1
