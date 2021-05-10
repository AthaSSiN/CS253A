#!/bin/bash

# The explanation for these steps is in the steps.txt file
scriptPIDS=(`ps -o pid,comm | grep script.sh | grep -o '[0-9]*'`) # [0-9]* is a regex, and x=(`cmd`) means the output of running command cmd will be stored as an array x.
for ((i=0;i<${#scriptPIDS[@]};i++)) # #scriptPIDS[@] gives the length of the array scriptPIDS
do
	PGID=`ps --ppid ${scriptPIDS[$i]} -o pgid,comm| grep timeout | grep -o '[0-9]*'`
	kill -9 -$PGID # kill groups with parent group id $PGID
done
