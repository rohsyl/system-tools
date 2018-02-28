#!/bin/bash
#
# ajoute le numéro de saison et remets les numeros d'épisode a 0
#
# args :
#
# 1	index de début
# 2	nombres de chiffres
# 3	numéro de saison
# 4	move pour appliquer les modifs
#

if [[ "$1" = "help" ]]; then
	echo "# ajoute le numéro de saison et remets les numeros d'épisode a 0"
	echo "#"
	echo "# args :"
	echo "#"
	echo "# 1	index de début"
	echo "# 2	nombres de chiffres"
	echo "# 3	numéro de saison / -1 pour ne pas ajouter"
	echo "# 4	move pour appliquer les modifs"
else
	getnum=false
	num=0
	for file in *
	do
		debut=${file:0:$1}
		e=${file:$1:$2}
		indexfin=$(($1+$2))
		fin=${file:$indexfin}
		e=$(echo $e | sed 's/^0*//')
		if [ "$getnum" = "false" ]; then
				num=$((e-1))
			getnum=true
		fi
		e=$((e-num))
		if [[ $e =~ .[0-9] ]]; then
			i=""
			e=$i$e
		else
			i="0"
			e=$i$e
		fi
		if [ "$3" = "-1" ]; then
			x=""
			y=""
		else 
			x="S0$3"
			y="E"
		fi
		f=$x$y$e
		j="$debut$f$fin"

		if [[ $file != ${0##*/} ]]; then
			echo $j
			if [[ "$4" = "move" ]]; then
				mv "$file" "$j"
			fi
		fi
	done
fi
