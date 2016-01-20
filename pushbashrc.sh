#!/bin/bash

user="br876718"
levelfile="serverLevel.txt"
appfile="appServer.txt"

IFS=$'\n'
for level in `cat $levelfile`
do
    for app in `cat $appfile`
    do
	server=$app$level 
	echo "Updating $server..."
    	scp -r ~/.bashrc $user@$server:~/.bashrc
    done	
done

echo "Done!"
exit 0
