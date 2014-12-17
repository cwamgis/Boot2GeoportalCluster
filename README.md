Boot2GeoportalCluster
=====================

# Présentation :
Boot2GeoportalCluster est un automatiseur de création de clusters Geoserver + Postgres (avec Postgis). L'utilisateur peut accéder à l'interface web de Geoserver (127.0.0.1:8080/geoserver) à travers le serveur web et répartiteur de charges [Dyn-nginx](https://registry.hub.docker.com/u/dduportal/dyn-nginx/) 

![Architecture logicielle](https://github.com/cwamgis/Boot2GeoportalCluster/blob/master/images/architecture_logiciel.png)

# Mode d'emploi :

1. Ouvrir une invite de commande.
2. Lancer la commande **git clone https://github.com/cwamgis/Boot2GeoportalCluster.git**.
3. Se placer à la racine du dossier
4. Si votre connexion passe par un proxy, éditer proxy/proxy.bat pour correspondre à sa configuration. Il est configuré par défaut pour une connexion depuis le réseau de l'ENSG. Puis, le lancer via la commande **proxy/proxy.bat**.
5. Lancer **vm/run_vm.bat**.
Cette commande va télécharger et lancer la machine virtuelle sur laquelle nous allons travailler.
run_vm.bat dl + lance la vm
-cd /vagrant/sh_boot2geoportal
sh run.sh
Entrer le nombre de geoservers voulus, confirmer.
{Tue tous les conteneurs existants
Construit les images [geoserver;datadir ; dbclient] si elles n'existent pas déjà
Datadir répertoire partagé par toutes les instances de geoserver contenant les données & les données d'initialisation
dbclient client postgre

Lance les geoservers


Dans le fichier yml : crée les conteneurs et définit les liens & interactions entre eux
