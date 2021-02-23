#!/bin/bash

# The explanation for these steps is in the steps.txt file
unzip q1-cs253.zip -d q1-cs253
cd q1-cs253
chmod u+rx 5688bc90-ab36-4a02-b192-d2426572bc93.gz
chmod u+rx deploy.gz
gzip -d 5688bc90-ab36-4a02-b192-d2426572bc93.gz
gzip -d deploy.gz

chmod u+rx 5688bc90-ab36-4a02-b192-d2426572bc93
echo "Running 5688bc90-ab36-4a02-b192-d2426572bc93"

# package name line is of a format like: package_name -> Tx45V4MEJtfFEOT
pkgName=`./5688bc90-ab36-4a02-b192-d2426572bc93 | grep package_name | grep -o '.\{15\}$'` # as package name is 15 chars long, grep last 15 chars of the line containing the word package_name, using regex.

echo "Package name:" $pkgName
echo

files=(`ls --group-directories-first`) # lists all files in the folder, directories first, and stores the list in the array files
# As there are only 2 folders inside the folder, we need to work with files[0] and files[1] only

chmod u+rx ${files[0]} ${files[1]} deploy

f0=(`ls ${files[0]}`) # lists content inside directory files[0] and saves it to array f0
if((${#f0[@]}==1)) # checks if the length of array f0 is 1
then
	dateFolder=${files[0]} # as the folder containing date info is expected to have one file only
	serverFolder=${files[1]}
else
	serverFolder=${files[0]}
	dateFolder=${files[1]}
fi

echo "Date details are in Folder" $dateFolder
echo "Server details are in Folder" $serverFolder
echo
echo "Running deploy script with arguments" $dateFolder $pkgName $serverFolder "190200"
echo "Saving output to submission-q1.txt"
./deploy $dateFolder $pkgName $serverFolder 190200 >> ../submission-q1.txt
echo
echo "Contents of submission-q1.txt are: "
cat ../submission-q1.txt
