#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# catalog fat drives for video watching on the TV
# FYI I embedded fatsort in fat-cat.sh, now all-in-one
clear
source ~/data/global.dat

title-80.sh -t line "FAT Flash Drive Catalog: fat-cat.dat\ndelete empty directories"
sleep $(echo "scale=3; $dly / 2" | bc)

#echo -e "\n$div_d\nre-mouting android\n$div_s"
#str=$(mnta.sh -u)                                        # remount android
#printf "%9s: %s\n" $str                                  # neatly printed
#sleep $(echo "scale=3; $dly / 2" | bc)
#str=$(mnta.sh)
#printf "%9s: %s\n" $str

f=0
unset LC_ALL

for tgt in $MEDIA/*                                      # find FAT drives
do
   typ=$(findmnt -no fstype "$tgt")
   if [ $typ = "vfat" ] || [ $typ = "exfat" ]
   then
      find $tgt -mindepth 1 -type d -empty -delete       # remove empty dirs
      f=$((f+=1))
      drv=${tgt##*/}                                     # get drv name w/o pth
      dev=$(findmnt -no source $tgt)
      use=$(findmnt -o used,avail,size $tgt)             # drive stats
      echo -e "\n$div_d\n$dev $tgt $HOME/data/fat-cat-$drv.dat\n$div_s"
      echo -e "$use\n" > "$HOME/data/fat-cat-$drv.dat"   # erase output file

      mnt.sh -u $dev
      sudo fatsort $dev
      mnt.sh $dev
                                                         # short tree script
      echo -e "\n$div_s\n     creating catalog for: $tgt"
      tree.sh $tgt >> "$HOME/data/fat-cat-$drv.dat"
                                                         # fat tree
      tree -nd --noreport $tgt > "$HOME/data/fat-tre-$drv.dat"
   fi
done

echo
title-80.sh -t line "> > > fat drives processed: $f < < <"

echo
xflash.sh
echo
fat-cat-sum.sh
