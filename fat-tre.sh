#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
title-80.sh -t line "fat-tre-*.dat brief FAT tree | alias fatree='fat-tre.sh'"
sleep 1
for fil in ~/data/fat-tre-*
do
   echo
   cat $fil
done
