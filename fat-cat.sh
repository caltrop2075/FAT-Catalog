#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# catalog fat drives for video watching on the TV
# FYI embedded fatsort in fat-cat.sh, now all-in-one
#
# rewrote fat-cat.sh to have option for catalog only
# I figured sorting the directory all the time was over using the drives
# now after adding videos or deleting just catalog
# major changes will require sorting
#
# any FAT gets cataloged, but deletes flash backup files
#
# alias
# fatcat       fat-cat.sh        catalog w/opt sort
# fatcated     fat-cat-ed.sh     open data files in text editor
# fatcatdir    fat-cat-dir.sh    dir tree
# fatcatdrv    fat-cat-drv.sh    quick summary of drives
# fatcatgrp    fat-cat-grep.sh   search data files
# fatcatsum    fat-cat-sum.sh
#
# 2023-09-04 added directory only sort
#
#---------------------------------------------------------------- initialization
clear
source ~/data/global.dat
dly=2    # $(echo "scale=3; $dly / 2" | bc)
#------------------------------------------------------------- android - defunct
#echo -e "\n$div_d\nre-mouting android\n$div_s"
#str=$(mnta.sh -u)                                        # remount android
#printf "%9s: %s\n" $str                                  # neatly printed
#sleep $dly
#str=$(mnta.sh)
#printf "%9s: %s\n" $str

if [[ "$1" == "-h" || "$1" == "--help" ]]
then
   echo
   echo "usage: fat-cat.sh [-c -d -h]"
   echo "       no option  process FAT drives"
   echo "       -c         catalog only"
   echo "       -d         directory only"
   echo "       -h         help"
   exit
fi
f=0
title-80.sh -t line "FAT Flash Drive Catalog: fat-cat.dat"
sleep $dly
unset LC_ALL
#--------------------------------------------------------------- find FAT drives
for tgt in $MEDIA/*
do
   typ=$(findmnt -no fstype "$tgt")
   if [[ $typ == "vfat" ]] || [[ $typ == "exfat" ]]
   then
      dev=$(findmnt -no source $tgt)
      echo -e "\n$div_d\n$dev $tgt $HOME/data/fat-cat-$drv.dat\n$div_s"
      ((f++))
      drv=${tgt##*/}                                     # get drv name w/o pth
      if [[ $1 == "-c" ]]                                # catalog only
      then
         echo "no sort - catalog only"
         sleep $dly
      else
         echo "delete empty directories"
         find $tgt -mindepth 1 -type d -empty -delete    # remove empty dirs
         mnt.sh -u $dev                                  # sort
         if [[ $1 == "-d" ]]
         then
            echo "directory only"
            sleep $dly
            sudo fatsort -D / $dev
         else
            sudo fatsort $dev
         fi
         mnt.sh $dev
      fi
      echo -e "\n$div_s\ncreating catalog for: $tgt"
      use=$(findmnt -o used,avail,size $tgt)             # drive stats
      echo -e "$use\n" > "$HOME/data/fat-cat-$drv.dat"   # initialize output file
      tree.sh -NUn $tgt >> "$HOME/data/fat-cat-$drv.dat" # fat tree
      tree.sh -NUnd --noreport $tgt > "$HOME/data/fat-tre-$drv.dat" # short tree
   fi
done
#------------------------------------------------------------------------- stats
echo
title-80.sh -t line "> > > fat drives processed: $f < < <"
#------------------------------------------------------------- unmount all flash
echo
xflash.sh
#-------------------------------------------------------- delete flash bkp files
title-80.sh -t line "Delete Flash Backup FAT Catalog"
find ~/Flash -mindepth 1 -maxdepth 1 -type d | sort |
while read tgt
do
   nam=${tgt##*/}
   find ~/data -type f -name "fat-*$nam.dat" -printf "%f\n" -delete | sort
done
#----------------------------------------------------------------- color summary
sleep $dly
echo
fat-cat-sum.sh
#-------------------------------------------------------------------------------
