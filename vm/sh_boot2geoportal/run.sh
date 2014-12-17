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
	dfig rm --force
	docker build -t busybox_datadir dockerfile_datadir
	docker build -t jamesbrink_chargepg dockerfile_dbclient 

	# start cluster
	dfig up -d 
	dfig scale geoserver=$geoserver_containers_number

	######################################### test chaque conteneur geoserver #######################################
	



	# on va boucler et attendre tant que le geoserver du conteneur ne repond pas present
	while true
	do
		clear
		echo =================================================
		echo "test connexion geoserver...  "
		echo =================================================
		curl -I "http://localhost:8080/geoserver" | grep "302"
		if [ $? -eq 0 ]
		then break
		else 
			sleep 5
		fi
	done
	
	echo "at least, one docker is ok, wait for 10 sec in order to be sure that other are listening... "	
	sleep 10
	#################################################################################################################
	
	# creation de lentrepot ensg_gtsi sur geoserver
	echo =================================================
	echo "creating the workspace ensg_gtsi..."
	echo =================================================
	curl -v -u admin:geoserver -XPOST -H "Content-type: text/xml" -d "<workspace><name>ensg_gtsi</name></workspace>" http://localhost:8080/geoserver/rest/workspaces
	echo =================================================
	echo "reloading all geoserver containers..."
	echo =================================================
	sh reload_conteneurs_geoserver.sh
	
	# creation du datastore
	echo =================================================
	echo "creating the datastore..."
	echo =================================================
	curl -v -u admin:geoserver -XPOST -T ./entrepot_geoserver/datastore.xml -H "Content-type: text/xml" http://localhost:8080/geoserver/rest/workspaces/ensg_gtsi/datastores
	echo =================================================	
	echo "reloading all geoserver containers..."
        echo =================================================
	sh reload_conteneurs_geoserver.sh

	# creation de la couche
	echo =================================================	
	echo "creation de communes layer..."
	echo =================================================
	curl -v -u admin:geoserver -XPOST -H "Content-type: text/xml" -T ./entrepot_geoserver/featuretype.xml  http://localhost:8080/geoserver/rest/workspaces/ensg_gtsi/datastores/boot2geoportal/featuretypes
	echo =================================================
	echo "reloading all geoserver containers..."
	echo =================================================
        sh reload_conteneurs_geoserver.sh

	clear
	echo "******************************************LISTE CONTENEURS*************************************************"
	dfig ps
	echo "***********************************************************************************************************"

fi
