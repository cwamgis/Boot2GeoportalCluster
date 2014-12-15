#!/bin/sh
while true
do

	grep "ok" /data_dir/etatdbserver
        if [ $? -eq 0 ]
        	then break

	else
		sleep 5
	fi
done
sh /app/geoserver-2.6.1/bin/startup.sh
