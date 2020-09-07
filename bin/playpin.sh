#!/bin/sh

var="/home/vladislav/test/pics/Opium_Nap.jpg"
[ $2 = "$var" ] && echo woah
echo done

exit 0
if [ $# -gt 2 ]
then
    until [ -z "$1" ]; do
        a="$a\n$1"
        shift
    done
    echo "$a" | sxiv -as f -
fi
exit 0
