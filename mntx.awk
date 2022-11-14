#!/usr/bin/awk -f
# udisksctl mount -b /dev/sdb1 --no-user-interaction 2> /dev/null
# ------------------------------------------------------------------------------
BEGIN {
}
# ------------------------------------------------------------------------------
{
   switch($1)
   {
      case /^\/dev\/sda/ :
         break
      case /^\/dev\/sr.*/ :
         cmd="eject "$1
         print cmd
         system(cmd)
      default :
         if(u=="-u")
         {
            cmd="printf \"%-22s \" $(findmnt -no target "$1")"
            system(cmd)
            cmd="udisksctl unmount -b "$1" 2> /dev/null"
         }
         else
            cmd="udisksctl mount -b "$1" --no-user-interaction 2> /dev/null"
         # print cmd
         err=system(cmd)
         if(err)
            printf("no action %s\n",$1)
   }
}
# ------------------------------------------------------------------------------
END {
}
# ------------------------------------------------------------------------------
 
