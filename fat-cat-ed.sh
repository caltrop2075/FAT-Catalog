#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# open fat-cat-*.dat catalogs

#---------------------------------------------------------------- initialization
x1=1366     # internal monitor
y1=768

x2=1920     # external HDMI & VGA
y2=1080

dly=1.5

#------------------------------------------------------------------ set location
xrandr.sh
err=$?

case $err in
   1)
      x=0
      y=$((24))
      a=$((x1-200-8))
      b=$((y1-2*24))
      ;;
   2)
      x=$x1
      y=0
      a=$((x2))
      b=$((y2-24))
      ;;
   3)
      x=$((x1+x2))
      y=$((y2-y1+24))
      a=$((x1-200-8))
      b=$((y1-2*24))
      ;;
   *)
esac

printf "e:%s x:%s y:%s a:%s b:%s\n" $err $x $y $a $b
#----------------------------------------------------------- start xed fat-cat-*
xed ~/data/fat-cat-*.dat 2> /dev/null &
sleep $dly
#---------------------------------------------------------- find xed window name
tgt=$(wmctrl -lp | fat-cat-ed.awk -v p=$(pgrep xed))
echo $tgt
sleep $dly
#---------------------------------------------------------- configure xed window
wmctrl -Fr "$tgt" -b remove,maximized_horz,maximized_vert
sleep $dly
wmctrl -Fr "$tgt" -e 0,$x,$y,$a,$b
#-------------------------------------------------------------------------------
