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
echo "$(timestamp) : Cloning project from Github" >> $logfile
echo "-----------------------------------------" >> $logfile
git clone https://github.com/julian-code/makersofdenmark.git ./work-dir/
echo "$(timestamp) : Restoring project dependencies" >> $logfile
echo "-----------------------------------------" >> $logfile
cd work-dir
dotnet restores
echo "$(timestamp) : Running tests" >> $logfile
echo "-----------------------------------------" >> $logfile
dotnet test >> $logfile
echo "$(timestamp) : Publishing" >> $logfile
echo "-----------------------------------------" >> $logfile
dotnet publish -o publish >> $logfile
echo "$(timestamp) : Zipping published files" >> $logfile
echo "-----------------------------------------" >> $logfile
zip ./publish ./publish.zip
echo "$(timestamp) : Publishing to new directory" >> $logfile
echo "-----------------------------------------" >> $logfile

echo "$(timestamp) : All Done" >> $logfile
