#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# open fat-cat-*.dat catalogs

# --------------------------------------------------------------- initialization
x1=1366     # internal monitor
y1=768

x2=1920     # external HDMI & VGA
y2=1080

dly=1

# ----------------------------------------------------------------- set location
xrandr.sh
err=$?

      x=0
      b=$((y1-2*24))
case $err in
   1)
      y=$((24))
      a=$((x1-200-8))
      ;;
   2)
      y=$((y2-y1+24))
      a=$((x1-200-8))
      ;;
   3)
      y=$((y2-y1+24))
      a=$((x1-200-8))
      ;;
   *)
esac

printf "e:%s x:%s y:%s a:%s b:%s\n" $err $x $y $a $b

# ---------------------------------------------------------- start xed fat-cat-*
xed ~/data/fat-cat-*.dat 2> /dev/null &
sleep $dly

# --------------------------------------------------------- find xed window name
tgt=$(wmctrl -lp | fat-cat-ed.awk -v p=$(pgrep xed))
echo $tgt

# --------------------------------------------------------- configure xed window
wmctrl -Fr "$tgt" -b remove,maximized_horz,maximized_vert
sleep $dly
wmctrl -Fr "$tgt" -e 0,$x,$y,$a,$b
