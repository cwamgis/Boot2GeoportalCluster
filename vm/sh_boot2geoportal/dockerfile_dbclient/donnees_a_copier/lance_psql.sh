#!/bin/sh
while true
do
	psql -h dbserver -U postgres -f /tmp/bd_postgis.sql
	if [ $? -eq 0 ]
	then break
	else
		sleep 5
	fi
done
echo "dbserver ok" >> /data_dir/etatdbserver
