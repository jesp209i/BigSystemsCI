#!/bin/bash
filetimestamp() {
  date +%Y%m%d_%H%M%S
}
timestamp() {
  date +"%FT%T%Z"
}
path=$(pwd)
logfile="$path/$(filetimestamp)_log.txt"
touch $logfile
echo "Cloning project fra Github"
echo "$(timestamp) : Cloning project from Github" >> $logfile
echo "-----------------------------------------" >> $logfile
git clone https://github.com/julian-code/makersofdenmark.git ./project/
echo "Restoring project dependencies"
echo "$(timestamp) : Restoring project dependencies" >> $logfile
echo "-----------------------------------------" >> $logfile
cd project
dotnet restore >> $logfile
echo "Running tests"
echo "$(timestamp) : Running tests" >> $logfile
echo "-----------------------------------------" >> $logfile
dotnet test --no-restore >> $logfile
echo "Publishing"
echo "$(timestamp) : Publishing" >> $logfile
echo "-----------------------------------------" >> $logfile
dotnet publish -o publish --no-restore >> $logfile
echo "Zipping published files"
echo "$(timestamp) : Zipping published files" >> $logfile
echo "-----------------------------------------" >> $logfile
cd publish 
zip ../../publish.zip ./* >> $logfile
cd ..
cd ..
echo "Unzipping published files to newdir"
echo "$(timestamp) : Publishing to new directory" >> $logfile
echo "-----------------------------------------" >> $logfile
mkdir newdir
unzip publish.zip -d ./newdir >> $logfile
echo "$(timestamp) : All Done" >> $logfile
