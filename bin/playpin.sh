#! /bin/bash

echo arg1:$1
file=${1:-$HOME/.helpful_commands}
echo $file
exit 0

var=$(ls $1 | grep dotfiles)
success=$?
echo success:$success

exit 0
