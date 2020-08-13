#!/bin/sh

# This is supposed to be used in rifle.conf as a workaround for the fact that
# sxiv takes no file name arguments for the first image, just the number.  Copy
# this file somewhere into your $PATH and add this at the top of rifle.conf:
#   mime ^image, has sxiv, X, flag f = path/to/this/script -- "$@"

# The filename is still being passed with --, not being used though

sorted_files_path="$HOME/.local/share/ranger/copy_sorted_files"

# grab the first line, containing a number of which index the cursor is on
c_index=$(sed 1q "$sorted_files_path")

sed -n -e '2,$p' "$sorted_files_path" | sxiv -n $c_index -ras f -

exit 0
