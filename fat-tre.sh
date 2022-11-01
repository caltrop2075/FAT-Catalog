#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# fat-cat tree listing
# modified to compact
# add sed to remove special chars sol 'column' works
#
title-80.sh -t line "Brief FAT Tree\nexcluding Jerry's Music"
out="$HOME/temp/temp.dat"
echo -n > "$out"

find ~/data -type f \! -name "fat-tre-16GB-1.dat" -name "fat-tre-*" | sort |
while read fil
do
   cat $fil | fat-tre.sed >> "$out"
   echo >> "$out"
done
cat ~/temp/temp.dat | column -e
