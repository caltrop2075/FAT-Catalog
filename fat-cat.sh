#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# catalog fat drives for video watching on the TV
# FYI I embedded fatsort in fat-cat.sh, now all-in-one
clear
source ~/data/global.dat

title-80.sh -t line "FAT Flash Drive Catalog: fat-cat.dat"
sleep $(echo "scale=3; $dly / 2" | bc)

#echo -e "\n$div_d\nre-mouting android\n$div_s"
#str=$(mnta.sh -u)                                        # remount android
#printf "%9s: %s\n" $str                                  # neatly printed
#sleep $(echo "scale=3; $dly / 2" | bc)
#str=$(mnta.sh)
#printf "%9s: %s\n" $str

if [[ "$1" == "-h" || "$1" == "--help" ]]
then
   echo "usage: fat-cat.sh [-t -h]"
   echo "       no option  process FAT drives"
   echo "       -c         catalog only"
   echo "       -h         help"
fi
f=0
unset LC_ALL

for tgt in $MEDIA/*                                      # find FAT drives
do
   typ=$(findmnt -no fstype "$tgt")
   if [ $typ = "vfat" ] || [ $typ = "exfat" ]
   then
      dev=$(findmnt -no source $tgt)
      echo -e "\n$div_d\n$dev $tgt $HOME/data/fat-cat-$drv.dat\n$div_s"
      ((f++))
      drv=${tgt##*/}                                     # get drv name w/o pth
      if [[ $1 != "-c" ]]
      then
         echo "delete empty directories"
         find $tgt -mindepth 1 -type d -empty -delete    # remove empty dirs
         mnt.sh -u $dev                                  # sort
         sudo fatsort $dev
         mnt.sh $dev
      else
         echo "no sort - catalog only"
      fi
      echo -e "\n$div_s\ncreating catalog for: $tgt"
      use=$(findmnt -o used,avail,size $tgt)             # drive stats
      echo -e "$use\n" > "$HOME/data/fat-cat-$drv.dat"   # initialize output file
      tree.sh $tgt >> "$HOME/data/fat-cat-$drv.dat"      # fat tree
      tree.sh -nd --noreport $tgt > "$HOME/data/fat-tre-$drv.dat" # short tree
   fi
done

echo
title-80.sh -t line "> > > fat drives processed: $f < < <"

echo
xflash.sh
echo
fat-cat-sum.sh
