#!/bin/bash

i=1
while read line
do
    echo "$line" |grep -q "object_id"
    if [ $? -eq 0 ]
    then
        hh=`echo "$line" | cut -f 2 -d ' '`
        realpath=`echo "http://blob.cfblob.com/$hh"`
        
        j=`expr $i - 1`
        filepath=`sed -n "$j p" /home/vcap/blobs.yml`
        dir=`echo $filepath | cut -f 1 -d '/'`
        filename=`echo $filepath | cut -f 2 -d '/' | cut -f 1 -d ':'`
        echo $dir $filename $realpath
        mkdir -p $dir
        wget -c $realpath -O $dir/$filename
    fi
let i++
done < /home/vcap/blobs.yml
