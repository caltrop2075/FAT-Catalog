#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# fat-cat directory tree
#
#
clear
source ~/data/global.dat

rm -f ~/data/fat-tre-*
for tgt in ~/data/fat-cat-*.dat
do
   echo "$div_s"
   out=${tgt/-cat-/-tre-}
   cat $tgt | fat-cat-dir.awk | tee "$out"
done
echo "$div_s"
