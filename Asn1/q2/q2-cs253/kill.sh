#!/bin/bash

scriptPIDS=(`ps -o pid,comm | grep script.sh | grep -o '[0-9]*'`)
for ((i=0;i<3;i++))
do
	PGID=`ps --ppid ${scriptPIDS[$i]} -o ppid,comm| grep timeout | grep -o '[0-9]*'`
	kill -9 -$PGID
done
