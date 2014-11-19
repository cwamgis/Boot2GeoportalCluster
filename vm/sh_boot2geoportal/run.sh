#!/bin/sh







alias dfig="docker run -ti -v \$(pwd):/app -v /vagrant:/vagrant -v /var/run/docker.sock:/var/run/docker.sock dduportal/fig"



dfig kill
dfig rm --force
dfig up -d 
sleep 5



# On cree deux conteneurs pour le service geoserver
#dfig scale geoserver=2 
# Load data set

dfig run dbserver psql -h app_dbserver_1 -p 5432 -U postgres -f /vagrant/donnees_boot2geoportal/bd_postgis.sql
