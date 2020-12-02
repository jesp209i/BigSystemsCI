#!/bin/bash
echo "Hello World"
#git clone https://github.com/julian-code/makersofdenmark.git ./work-dir/

filetimestamp() {
  date +"%Y-%m-%d_%H-%M"
}
timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}
logfile="$(filetimestamp)-log.txt"

touch $logfile
echo "$(timestamp) : Cloning project from Github" >> $logfile
echo "-----------------------------------------" >> $logfile
git clone https://github.com/julian-code/makersofdenmark.git ./work-dir/
echo "$(timestamp) : Restoring project dependencies" >> $logfile
echo "-----------------------------------------" >> $logfile
cd work-dir
dotnet restore
echo "$(timestamp) : Running tests" >> ../$logfile
echo "-----------------------------------------" >> ../$logfile
dotnet test >> $logfile
echo "$(timestamp) : Publishing" >> ../$logfile
echo "-----------------------------------------" >> ../$logfile
dotnet publish -o publish >> ../$logfile

echo "$(timestamp) : All Done" >> ../$logfile
