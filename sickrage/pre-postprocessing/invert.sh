#!/bin/bash
#
# inverse le numéro d'épisode et de série type 00x0 en s00E00
#
# args :
#
# 1	index de début
# 2	nombres de chiffre
# 3	move pour appliquer les modifs
#

if [[ "$1" = "help" ]]; then 
	echo "#"
	echo "# inverse le numéro d'épisode et de série type 00x0 en s00E00"
	echo "#"
	echo "# args :"
	echo "#"
	echo "# 1     index de début"
	echo "# 2     nombres de chiffre"
	echo "# 3     move pour appliquer les modifs"
	echo "#"
else

for file in *
do

debut=${file:0:$1}
serep=${file:$1:$2}
indexfin=$(($1+$2))
fin=${file:$indexfin}

episode=${serep%x*}
serie=${serep#*x}

episode=$(echo $episode | sed 's/^0*//')
serie=$(echo $serie | sed 's/^0*//')


if [[ $episode =~ .[0-9] ]]; then
	i=""
	episode=$i$episode
else
	i="0"
	episode=$i$episode
fi

x="S0$serie"
y="E$episode"
f=$x$y
j="$debut$f$fin"

if [[ $file != ${0##*/} ]]; then
	echo $j
	if [[ "$3" = "move" ]]; then
		mv "$file" "$j"
	fi
fi

done

fi

