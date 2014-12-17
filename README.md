Boot2GeoportalCluster
=====================

# Présentation :
Boot2GeoportalCluster est un automatiseur de création de clusters Geoserver + Postgres (avec Postgis). L'utilisateur peut accéder à l'interface web de Geoserver (127.0.0.1:8080/geoserver) à travers le serveur web et répartiteur de charges [Dyn-nginx](https://registry.hub.docker.com/u/dduportal/dyn-nginx/) 

![Architecture logicielle](https://github.com/cwamgis/Boot2GeoportalCluster/blob/master/images/architecture_logiciel.png)

# Mode d'emploi :

1. Ouvrir une invite de commande ;
2. Lancer la commande **git clone https://github.com/cwamgis/Boot2GeoportalCluster.git** ;
3. Se placer à la racine du dossier ;
4. Si votre connexion passe par un proxy, éditer proxy/proxy.bat pour correspondre à sa configuration. Puis, le lancer via la commande **proxy/proxy.bat** ;
5. Lancer **vm/run_vm.bat** : cette commande va télécharger et lancer la machine virtuelle sur laquelle nous allons travailler ;
6. Lancer **sh /vagrant/sh_boot2geoportal/run.sh**, préciser le nombre d'instances de geoserver souhaitées et confirmer. **Il est fortement recommandé de ne pas dépasser 3 geoservers sous peine de faire crasher la machine.** Une fois cette commande exécutée, tous les geoservers seront lancés et prêts à l'emploi.

# Détails du fonctionnement de run.sh

1. Tue tous les conteneurs existants et les supprime ;
2. Construit les images *geoserver*, *datadir*, et *dbclient* si elles n'existent pas déjà ;
  1. Sans surprise, geoserver est l'image d'un geoserver ;
  2. datadir est un répertoire partagé par toutes les instances de geoserver qui contient les données qui seront rentrées dans les geoservers & les données d'initialisation ;
  3. dbclient est l'image d'un client postgre.
3. Lance le fichier *fig.yml*, qui va à son tour créer les conteneurs et définir les liens & interactions entre eux, les ports par lesquels ils communiquent, leurs variables d'environnement, etc. ;
4. Lance le nombre de geoservers spécifiés par l'utilisateur ;
5. Affiche les conteneurs.
