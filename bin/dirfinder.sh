#! /bin/bash

# Author : Austin Burt
# Email  : austin@burt.us.com
# Date   :

# [[ -z $PROGRAM ]] && declare -r PROGRAM=$(basename $0)
# [[ -f $HOME/bin/colorValues ]] && source $HOME/bin/colorValues

datafile="$HOME/.local/share/ranger/alldirsdata.txt"

add_dash() {
  awk '{print "-",$0}'
}

replace_paths() {
  local home=$HOME
  local shared=$HOME/shared_drive
  local tilde="~"
  local sd=SD
  if [[ "$1" != "back" ]]
  then
    sed -E 's|('$shared')|'${sd}'| ; s|('$home')|'$tilde'|'
  else
    sed -E 's|^. || ; s|('$tilde')|'$home'| ; s|('$sd')|'$shared'|'
  fi
}

sed -e 's/:/ /' "$HOME/.local/share/ranger/bookmarks" | replace_paths > $datafile
fdfind -t d --search-path="$HOME" | replace_paths | add_dash >> $datafile
fdfind -t d --search-path="$HOME/shared_drive/" | replace_paths | add_dash >> $datafile
destdir=$(cat $datafile | dmenu -l 20 -i -p "Move file(s) to where?" )
destdir=$(echo $destdir | replace_paths "back" )
echo $destdir

# [ ! -d "$destdir" ] && notify-send "$destdir is not a directory, cancelled." && exit
# mv "$file" "$destdir" && notify-send -i "$(readlink -f "$file")" "$file moved to $destdir." &
