#! /bin/bash

# bash-redirection.sh
# Author : Austin Burt
# Email  : austin@burt.us.com
# Date   : 04/22/2022

ERRORFILE="$HOME/tmp/ErrorFile.log"
ERRORFILE2="$HOME/tmp/ErrorFile2.log"

_prepend_date() {
  sed -e 's/^/'$(date +'[%FX%T]')' /' -e 's/X/ /'
}

exec 2> >(sed -e 's/^/'$(date +'[%FX%T]')' /' -e 's/X/ /' >> $ERRORFILE)
exec 3> >(_prepend_date >> $ERRORFILE2)

echo -e "output will also be sent to:\n\t'$ERRORFILE' \n\tand\n\t'$ERRORFILE2'\n"
echo "I'm just plain old stdout"
echo "Im a redirected error" >&2
echo "Im a custom error" >&3

exit 0
