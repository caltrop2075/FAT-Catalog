#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# mount/unmount all external drives
echo -n > ~/temp/temp                                          # standard drives
for tgt in /dev/sd??*
do
   echo "$tgt" >> ~/temp/temp
done
for tgt in /dev/mmcblk???*
do
   echo "$tgt" >> ~/temp/temp
done
cat ~/temp/temp | mntx.awk -v u="$1"

#if [[ $1 == "-u" ]]                                            # android
#then
#   mnta.sh -u
#else
#   mnta.sh
#fi
