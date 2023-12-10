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
            printf("\033[0;35m")          # magenta
            break
         case 2 :
            printf("\033[0;34m")          # blue
            break
         case 3 :
            printf("\033[0;36m")          # cyan
            break
         case 4 :
            printf("\033[0;32m")          # green
            break
         case 5 :
            printf("\033[0;33m")          # yellow
            break
         case 6 :
            printf("\033[0;31m")          # red
            break
      }
      y=int(x*i)-int(x*(i-1))
      for(j=0;j<y;j++)
         switch(i)                        # bar ░ ▒ ▓ █
         {
            case 6 :                      # red
               printf("█")
               break
            case 1 :                      # magenta
            case 2 :                      # blue
            case 4 :                      # green
            case 5 :                      # yellow
               printf("▓")
               break
            case 3 :                      # cyan
               printf("▒")
               break
            default :
               printf("░")
         }
   }
   printf("\033[0m\n")
}
# ==============================================================================
