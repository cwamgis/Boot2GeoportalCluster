#!/bin/sh

for idConteneur in $(docker ps | grep "dduportal/geoserver" | awk '{ print $1 }')
do
	IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' $idConteneur`
	no_proxy=$no_proxy,$IP
	curl -u admin:geoserver -v -XPOST http://${IP}:8080/geoserver/rest/reload
done
