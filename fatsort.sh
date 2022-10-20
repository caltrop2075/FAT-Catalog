#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# language setting rears its ugly head again
# FYI I embedded fatsort in fat-cat.sh, now all-in-one
clear
source ~/data/global.dat
title-80.sh -t line "sorting all FAT drives"
unset LC_ALL
lsblk -rno name,fstype,label | fatsort.awk
echo -e "\ndone\n"
