#!/usr/bin/awk -f
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# needed floating point calculations for variable bar legend
# ==============================================================================
BEGIN {
   x=(w-7)/6
   printf("%7s","")
   for(i=1;i<=6;i++)
   {
      switch(i)                           # color
      {
         case 1 :
            printf("\033[0;35m")
            break
         case 2 :
            printf("\033[0;34m")
            break
         case 3 :
            printf("\033[0;36m")
            break
         case 4 :
            printf("\033[0;32m")
            break
         case 5 :
            printf("\033[0;33m")
            break
         case 6 :
            printf("\033[0;31m")
            break
      }
      y=int(x*i)-int(x*(i-1))
      for(j=0;j<y;j++)
         switch(i)                        # bar ░ ▒ ▓ █
         {
            case 1 :
            case 2 :
            case 3 :
            case 5 :
               printf("▓")
               break
            case 4 :
               printf("▒")
               break
            case 6 :
               printf("█")
               break
            default :
               printf("░")
         }
   }
   printf("\033[0m\n")
}
# ==============================================================================
