Boot2GeoportalCluster
=====================

# Présentation

Boot2GeoportalCluster permet d'automatiser la création d'une architecture composée de clusters Geoserver et d'un serveur PostgreSQL (avec PostGIS).
La procédure détaillée ici concerne la configuration du système pour une machine hôte Windows sur laquelle Virtual Box et Vagrant sont installés.
L'application utilise une machine virtuelle qui tourne Boot2Docker et lance des conteneurs.

L'utilisateur peut accéder à l'[interface web de GeoServer](http://127.0.0.1:8080/geoserver) à travers le serveur web et répartiteur de charges [Dyn-nginx](https://registry.hub.docker.com/u/dduportal/dyn-nginx/).


![Architecture logicielle](https://github.com/cwamgis/Boot2GeoportalCluster/blob/master/images/architecture_logiciel.png)

# Mode d'emploi

1. Ouvrir une invite de commande ;
2. Lancer la commande ```git clone https://github.com/cwamgis/Boot2GeoportalCluster.git``` ;
3. Se placer à la racine du dossier ;
4. Si votre connexion passe par un proxy, éditer proxy/proxy.bat pour correspondre à sa configuration. Puis, le lancer via la commande ```proxy/proxy.bat``` ;
5. Lancer ```vm/run_vm.bat``` : cette commande va configurer et lancer la machine virtuelle sur laquelle nous allons travailler, contenue dans le dossier *vm* ;
6. Lancer ```sh /vagrant/sh_boot2geoportal/run.sh```, préciser le nombre d'instances de GeoServer souhaitées et confirmer. **Attention à ne pas dépasser les capacités de votre machine en lançant trop de GeoServers à la fois, sous peine de crash.** Une fois cette commande exécutée, tous les GeoServers seront lancés et prêts à l'emploi.



définir les liens & interactions entre eux, les ports par lesquels ils communiquent, leurs variables d'environnement, etc. En particulier, il lance NGINX, qui va non seulement gérer la répartition des charges, mais aussi permettre à un utilisateur enregistré de garder la même identité (ie la même session ouverte) quelle que soit l'instance du GeoServer sur laquelle il a été redirigé ;

# Détails du fonctionnement de run.sh

1. Tue tous les conteneurs existants et les supprime ;
2. Construit des images docker propres à la présente application
3. Lance les conteneurs paramétrés dans fig.yml (grace à un alias dfig basé sur l'image dduportal/fig)
4. Demande à l'utilisateur de saisir un nombre de conteneurs geoserver et les lance (scale)
5. Cree l'espace de travail ensg_gtsi, le datastore poitnant sur la base de données Postgres, et la couche communes via un conteneur geoserver
5. Affiche la lsite des conteneurs lancés

# Le paramétrage des conteneurs

Le paramétrage des classes de conteneur se réalise via le fichier fig.yml.
Celui-ci comprend pour chaque classe conteneur le nom des images utilisées mais aussi les variables d'environnement associées, les redirections de port, les volumes montés ou le liens entre classes de conteneur.
Les différentes classes de conteneurs sont : 
  * dbserver (image jamesbrink/postgresql): serveur PostgreSQL
  * datadir (image propre à l'application basée sur busybox): sert de répertoire partagé aux conteneurs geoserver. Celui-ci contient le "data_dir" des geoservers décrivant toutes les informations de configuration associées aux données.
  * dbclient  (image propre à l'application basée sur jamesbrink/postgresql): va créer la base de données entrepot sur le serveur Postgres contenant la table Postgis communes
  * geoserver (dduportal/geoserver:2.6.1): geoserver
  * dynnginx (image propre à l'application basée sur dduportal/nginx:1.7.7) : c'est le load balancer qui répartit les requetes client sur les conteneurs Geoserver. Il permet également de gérer la persistance des sessions des utilisateurs (de manière transparente, l'utilisateur peut ainsi s'authentifier sur un conteneur puis se balader dans geoserver via un autre sans devoir se reconnecter)