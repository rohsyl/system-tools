#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# Incrémente / décrémente un nombre à trois chiffres max
#
# args :
#
# 1     index de début des nombres
# 2     nombre à incrémenter / décrémenter
# 3     move pour appliquer les modifs
#

import os
import shutil
import sys
import re


arg1 = int(sys.argv[1])
arg2 = int(sys.argv[2])

if len(sys.argv) > 3:
    arg3 = sys.argv[3]
else:
    arg3 = ''


current_directory = '.'
files = os.listdir(current_directory)
files.sort()

for child in files:
	debut = child[0:arg1]
	nb_raw = child[arg1:arg1+3]
	nb = int(nb_raw)
	indexfin = arg1 + len(str(nb_raw))-1
	fin = child[indexfin:len(child)]
	nb_incr = str(nb + arg2)
	if len(nb_incr) == 1:
		nb_incr = "0" + nb_incr
	file = debut + nb_incr + fin
	print file
	if arg3 == "move" :
		os.rename(child, file)
		print "Renamed"
