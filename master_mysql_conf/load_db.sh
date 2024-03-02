#!/bin/bash
ph=/home/dem/configs/db_arch

for i in $(ls $ph)
do
    mysql -e "CREATE DATABASE IF NOT EXISTS $i"
done

for i in $(ls $ph)
do
    for j in $(ls $ph/$i)
	do
    	    tmpvar=$(echo $j | sed 's/[a-zA-Z0-9_]*.//')
#	    echo $tmpvar
	    if [ $tmpvar = "sql.gz" ]
	    then
		gunzip $ph/$i/$j
	    fi
	done
done

for i in $(ls $ph)
do
    for j in $(ls $ph/$i)
    do
	mysql $i < $ph/$i/$j
    done
done









