#!/bin/bash
#
# ajoute le numéro de saison et remets les numeros d'épisode a 0
#
# args :
#
# 1	nom a rajouter
# 2	move pour appliquer les modifs
#

if [[ "$1" = "help" ]]; then
	echo "# ajoute le numéro de saison et remets les numeros d'épisode a 0"
	echo "#"
	echo "# args :"
	echo "#"
	echo "# 1	nom a rajouter"
	echo "# 2	move pour appliquer les modifs"
else
	for file in *
	do
		nomFichier=${file:0}
		autre=""
		j="$1$autre$nomFichier"

		if [[ $file != ${0##*/} ]]; then
			echo $j
			if [[ "$2" = "move" ]]; then
				mv "$file" "$j"
			fi
		fi
	done
fi
