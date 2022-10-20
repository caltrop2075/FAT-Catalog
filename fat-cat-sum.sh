#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# fat-cat-*.dat summary
# new & improved format & wider bargraph
# now with variable width, just mod w=?, 117 optimum for tile left/right
# added DEAD!/NOT IN USE/whatever, must be last line in file

w=117                                                 # width
o=$(($w-40))                                          # first column width
                                                      # title
s="fat-cat-*.dat summary | alias fatcatsum='fat-cat-sum.sh'"
l=${#s}              # str len      centering & width
q=4                  # bar spc 2x
a=$((($w-$q-$l)/2))  # left
b=$(($w-$a-$l-$q))   # right

d="\033[2;37m"                                        # divider
for ((i=0;i<w;i++))
do
   d=$d"─"
done
d=$d"\033[0m"
                                                      # headers
# did not use title-80.sh because of variable width
printf "%"$a"s%s%"$b"s\n" "" "$s" "" > ~/data/title.dat
title.sh -t double
printf "%-"$o"s%s\n" "NAM/USE%" "      DIR    FIL     USE     AVL     SIZ"

fat-cat-sum-bar.awk -v w=$w                           # bar legend

unset LC_ALL                                          # for printf %'6.0f
n=0
for tgt in ~/data/fat-cat-*                           # bar data
do
   ((n++))

   echo -e $d
   nam=${tgt#*/fat-cat-}
   nam=${nam%.dat}
   sta=$(tail -n 1 $tgt)
   printf "\033[1;31m%02d \033[1;37m%-"$o"s\033[0m" "$n" "$nam"
   if [[ $sta =~ "director" ]]                        # status handling
   then                                               # data
      dir=${sta%,*}
      dir=${dir% *}
      fil=${sta#*, }
      fil=${fil% *}
      printf "%'6.0f %'6d" "$dir" "$fil"
      head -n 2 $tgt | tail -n 1 | fat-cat-sum.awk -v w=$w
   else                                               # message
      printf "%13s\n" "$sta"
   fi

done
echo -e $d
