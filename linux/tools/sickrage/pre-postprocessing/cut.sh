#!/bin/bash
#
# cut un bout de nom de fichier possibilité de rajouter qqch
#
# args :
#
# 1	index de début
# 2	nombres de lettres a couper
# 3	char a ajouter après la découpe
# 4	move pour appliquer les modifs
#

if [[ "$1" = "help" ]]; then
	echo "# cut un bout de nom de fichier"
	echo "#"
	echo "# args :"
	echo "#"
	echo "# 1	index de début"
	echo "# 2	nombres de lettres a couper"
	echo "# 3	char a ajouter après la découpe"
	echo "# 4	move pour appliquer les modifs"
else
	for file in *
	do
		debut=${file:0:$1}
		indexfin=$(($1+$2))
		fin=${file:$indexfin}

		j="$debut$3$fin"

		if [[ $file != ${0##*/} ]]; then
			echo $j
			if [[ "$4" = "move" ]]; then
				mv "$file" "$j"
			fi
		fi
	done
fi
