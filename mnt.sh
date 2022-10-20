#!/usr/bin/bash
# mount/unmount a drive using udisksctl via awk to protect system drive
if [[ $# == 0 ]]
then
   echo -e "\nusage: mnt.sh [-u] /dev/sd??"
else
   o=$2
   d=$1
   if [[ $1 == "-u" ]]
   then
      o=$1
      d=$2
   else
      if [[ $2 == "-u" ]]
      then
         o=$2
         d=$1
      fi
   fi
   echo "$d" | mntx.awk -v u=$o
fi
