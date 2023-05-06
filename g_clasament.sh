#!/bin/bash

declare -A punctaj

nr_linii=`wc -l < etape.txt`
for i in $(seq 1 $nr_linii)
do
	linie=`awk 'NR=='$i' {print $0}' etape.txt`
	#echo $linie
	#echo $i

	echipa1=`echo $linie | awk 'NR==1 {print $1}'`
	echipa2=`echo $linie | awk 'NR==1 {print $4}'`
        goluri1=`echo $linie | awk 'NR==1 {print $2}'`
	goluri2=`echo $linie | awk 'NR==1 {print $3}'`

	#echo $echipa1
	#echo $goluri1
	#echo $echipa2
	#echo $goluri2
	#echo
	if [ $goluri1 -gt $goluri2 ]
	then
		((punctaj[$echipa1]+=3))
		#echo 'Echipa '$echipa1' are 3 puncte'
	elif [ $goluri2 -gt $goluri1 ]
	then
		((punctaj[$echipa2]+=3))
		#echo 'Echipa '$echipa2' are 3 puncte'
	elif [ $goluri1 -eq $goluri2 ]
	then
		((punctaj[$echipa1]+=1))
		((punctaj[$echipa2]+=1))
		#echo 'Echipele '$echipa1' si '$echipa2' sunt la egalitate'
	fi
done

for echipa in ${!punctaj[@]}; do
  printf "%-10s %d\n" ""$echipa"" "${punctaj["$echipa"]}"
done | sort -k2nr > clasament.txt
