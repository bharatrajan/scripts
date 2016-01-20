#!/bin/bash

if [ $# -eq 0 ];
then
    echo "Usage: ./tail.sh appname <unixid>"
    echo "REQUIRED: appname"
    echo "Supported apps: FCLA, WFCL, OADR,  WPOR"
    echo "OPTIONAL: unix id (if you need"
    echo "to run as another user)" 
    
    exit
    
else
    APPNAME=$1
    if [ ! -z $2 ]
    then
        user=$2
    else
        user=$USER
    fi
fi

if [ $APPNAME == "FCLA" ];
then
    a=26
    host1=fcla-cos
    host2=.zmd.fedex.com
    log="tail -f /var/log/local/local5"

    
elif [ $APPNAME == "WFCL" ];
then
    a=10
    host1=wfcl-cos
    host2=.zmd.fedex.com
    log="tail -f /var/log/local/local5"
elif [ $APPNAME == "WPOR" ];
then
    a=3
    host1=wpor-cos
    host2=.zmd.fedex.com
    log="tail -f /var/fedex/wpor-web/logs/nohup.out"

elif [ $APPNAME == "OADR" ];
then
    a=5
    host1=oadr-cos
    host2=.zmd.fedex.com
    log="tail -f /var/log/local/local5"
elif [ $APPNAME == "USRC" ];
then
    a=11
    host1=usrc-cos
    host2=.zmd.fedex.com
    log="tail -f /var/fedex/usrc-app/userCal.log"
    #log="grep CACS.SERVICE.FACTORY /var/fedex/usrc-app/userCal.log"
    #log="grep 507178561 /var/fedex/usrc-app/*"
elif [ $APPNAME == "USRCL6" ];
then
    a=2
    host1=usrctest-cos
    host2=.zmd.fedex.com
    log="tail -f /var/fedex/usrc-app/userCal.log"
elif [ $APPNAME == "REGCL6" ];
then
    a=2
    host1=regctest-cos
    host2=.zmd.fedex.com
    log="tail -f /var/fedex/regc-app/logs/regc-app.log"
elif [ $APPNAME == "REGC" ];
then
    a=4
    host1=regc-cos
    host2=.zmd.fedex.com
    log="tail -f /var/fedex/regc-app/logs/regc-app.log"
    #log="grep com.fedex.nxgen.cust.v8.ejb.custEJB_v8_crxoyi_HomeImpl_1032_WLStub /var/fedex/regc-app/logs/*"
else
    echo "$APPNAME Not Supported!"
    exit
fi

for i in $(seq 1 $a)
do
    if [ $(( $i % 2 )) -eq 0 ]
    then
        STRING="$STRING -ci green -l 'ssh $user@$host1$i$host2 $log'"
    else
        STRING="$STRING -l 'ssh $user@$host1$i$host2 $log'"
    fi
done

#Note: this line won't work with symlinks , etc.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
execute="$DIR/multi_tail/usr/bin/multitail $STRING"

eval $execute
