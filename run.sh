#!/bin/sh

# Creating the dfig alias
alias dfig="docker run -ti -v \$(pwd):/app -v /vagrant:/vagrant -v /var/run/docker.sock:/var/run/docker.sock dduportal/fig"

# How much Geoserver containers you need
echo -n "How much Geoserver containers you need in your cluster>"
read geoserver_containers_number

# Warning message about killing existing containers
echo =================================================
echo Warning !! All existing containers will be killed
echo =================================================

echo -n "Are you sure that you want to create $geoserver_containers_number containers ? (y/n)>"
read are_you_sure

if [ $are_you_sure != "y" ]
then
	echo "Aborted !"
else
	# Kill existing containers
	dfig kill
	dfig rm
	# start cluster
	dfig up -d 
	dfig scale geoserver=$geoserver_containers_number
fi
