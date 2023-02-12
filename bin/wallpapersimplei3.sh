#! /bin/bash

( while true
do
  nitrogen --random --head=0 --set-scaled ~/shared_drive/Pictures/wallpaper
  nitrogen --random --head=1 --set-scaled ~/shared_drive/Pictures/wallpaper
  sleep $((60*10))
done ) &
