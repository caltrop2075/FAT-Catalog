#!/usr/bin/awk -f
# ------------------------------------------------------------------------------
BEGIN {
   for(i=0;i<80;i++)
      div=div"-"
}
# ------------------------------------------------------------------------------
{
   switch($0)
   {
      case /^sd[b-z]+[0-9].*vfat/ :    # up to 32G, eg CRUZER & GO
      case /^sd[b-z]+[0-9].*exfat/ :   # over 32G, eg Android (64G micro sd)
         printf("\n%s\nfatsort -f no longer works so drive has to be unmounted first\n\n",div)

         cmd="mnt.sh -u /dev/"$1                      # unmount
         system(cmd)

         printf("\n%12s /dev/%s %s\n","drive:",$1,$3) # sort
         cmd="sudo fatsort -f /dev/"$1
         # print cmd
         system(cmd)

         printf("\n")                                 # mount
         cmd="mnt.sh /dev/"$1
         system(cmd)

#         cmd="tree "ENVIRON["MEDIA"]"/"$3" > "home"/data/Dir-"$3".dat"
#         system(cmd)

         system("sleep 3")
   }
}
# ------------------------------------------------------------------------------
END {
}
# ------------------------------------------------------------------------------
