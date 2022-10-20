#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# fat-cat file summary
# counts dir & empty lines so oth: ### will be over a bit

unset LC_ALL
w=6                                          # dec field wid, main wid control
c=5                                          # fields
d="\033[2;37m"                               # divider
for ((i=0;i<$((c*($w+7)+2));i++))
do
   d=$d"─"
done
d=$d"\033[0m"

for drv in $HOME/data/fat-cat-*.dat
do
   echo -e $d
   printf "%-$(((c-2)*($w+7)))s | " "${drv##*/}"
   cat $drv | fat-cat-fil.awk -v w=$w
done
echo -e $d
