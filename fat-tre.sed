#!/usr/bin/sed -Ef
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# -E extended regex, stuff like {n,m}
s/├/|/g           # convert lines to ascii
s/│/|/g
s/─/-/g
s/└/+/g
s/\xc2\xa0/ /g    # remove control chars
