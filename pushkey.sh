#!/bin/bash

if [ $# -lt 3 ] || [ $# -gt 4 ];
then
    echo "Usage: ./pushkey.sh host1 machines host2 <unix id>"
    echo ""
    echo "host1:    Hostname before the number"
    echo "machines: Number of machines"
    echo "host2:    Hostname after the number"
    echo "unix id:  (Optional) In case your id differs on the machines you are pushing to"
    echo ""
    echo "ex:       ./pushkey.sh wpor-cos 3 .zmd.fedex.com ct831972"
    echo ""
    exit
else
    host1=$1
    machines=$2
    host2=$3
    if [ ! -z $4 ]
    then
        user=$4
    else
        user=$USER
    fi
fi

for i in $(seq 1 $machines)
do
    server=$host1$i$host2
    echo "Updating $server..."
    scp -r ~/.ssh/* $user@$server:~/.ssh
done

echo "Done!"
