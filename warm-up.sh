#! /bin/sh
# This script warm-up geoserserver
# You can use it also to know which container crashed

alias dfig="docker run -ti -v \$(pwd):/app -v /vagrant:/vagrant -v /var/run/docker.sock:/var/run/docker.sock dduportal/fig"
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1"

for i in $(docker ps | grep "geoserver" | awk '{ print $1 }' | grep -v "CONTAINER" )
do
        IP=dip "$i"
        export no_proxy=${no_proxy},${IP}
        curl -I "http://$(dip "$i"):8080/geoserver"
done
