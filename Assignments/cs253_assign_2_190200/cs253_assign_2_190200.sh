#!/bin/bash

echo "$(date "+%m%d%Y %T") : Starting work" > error.log
echo "state,district,confirmed_Cases,recovery_Rate" > processed_Covid_Data_190200.csv

IFS=`echo -e '\t'`  # set the \t (tab) character as the internal field seperator to split array elements (otherwise it gets seperated at space by default, causing problem in district names with a space
states=(`jq -r 'keys | @tsv' covid_Data.json`) # returns list of states in a tab seperated form, which is written as an array into states array

for ((i=0;i<${#states[@]};i++)) # #states[@] returns the length of the array states
do
	echo "Processing state" ${states[$i]}
	districts=(`jq -r --arg state ${states[$i]} '.[$state]|.districts|keys|@tsv' covid_Data.json 2>>error.log`) # stores a list of district names of a state (if the state has no districts property, then this list is empty, and the error is saved in error.log)

	max_recovery_rate=0.00
	print_district=""
	print_cases=0
	for((j=0;j<${#districts[@]};j++)) # loop across all districts in a state
	do
		if [[ ${districts[$j]} != "Unknown" ]] # this condition ensures that the processed districts don't have the name "unknown"
		then
			temp_cases_overall=(`jq -r --arg state ${states[$i]} --arg dist ${districts[$j]} '.[$state].districts|.[$dist].total|[.confirmed,.recovered]|@tsv' covid_Data.json`) # temp variable to store total confirmed cases in a district
			temp_cases=${temp_cases_overall[0]}
			if [[ $temp_cases != '' ]] && (($temp_cases>=5000)) # process district if total confirmed cases >= 5000
			then
				temp_recovered=${temp_cases_overall[1]}
				temp_recovery_rate=`echo "scale=2; ($temp_recovered*100)/$temp_cases" | bc` # scale=2 ensures the answer is truncated to 2 decimal places.
				if (( `echo "$temp_recovery_rate >= $max_recovery_rate" |bc` )) # >= ensures that the disrict name processed later is displayed if multiple districts have the same max recovery rate
				then
					# replace all temp variables into permanent variables
					max_recovery_rate=$temp_recovery_rate 
					print_district=${districts[$j]}
					print_cases=$temp_cases
				fi
			fi
		fi
	done
	if (($print_cases!=0)) # print the details of a state only if the value of the permanent variables have changes (ensures states with no districts/unknown districts/districts with < 5000 infected people are not shown
	then
		echo ${states[$i]},$print_district,$print_cases,$max_recovery_rate >> processed_Covid_Data_190200.csv
	fi
done

echo "$(date "+%m%d%Y %T") : Finished work" >> error.log
echo
echo "Data written to processed_Covid_Data_190200.csv"
echo "Errors written to error.log"
echo "--------------------------------------------------------------"
echo "Contents of processed_Covid_Data_190200.csv:"
echo
cat processed_Covid_Data_190200.csv

####### PURE jq SOLUTION (uses 10 decimal places for comparison). It is very fast as compared to the above solution ################
# jq -r 'to_entries[] | select(.value.districts!=null) | .key as $k | [.value.districts|to_entries[]]| map(select(.key!="Unknown")) | map(select(.value.total.confirmed>=5000))|max_by(.value.total.recovered/.value.total.confirmed)|select(.value.total.confirmed!=null)|[ $k, .key, .value.total.confirmed, (.value.total.recovered*100/.value.total.confirmed) ]| @csv' covid_Data.json >> processed_Covid_Data_190200.csv
