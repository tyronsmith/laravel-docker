#!/bin/bash

for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            contname) CONTNAME=${VALUE} ;;
            repo) REPOSITORY=${VALUE} ;;     
			project) PROJNAME=${VALUE} ;; 
            *)   
    esac    


done

docker build -t laravel:latest .

docker run --name $CONTNAME -v $REPOSITORY:/var/www/html -d -p 80:80 laravel 

# run composer install on project folder
docker exec -u 0 $CONTNAME composer install -d /var/www/html/$PROJNAME
docker exec -u 0 $CONTNAME composer update -d /var/www/html/$PROJNAME

# install npm on project folder and run the manager
docker exec -u 0 $CONTNAME npm --prefix /var/www/html/$PROJNAME install /var/www/html/$PROJNAME
docker exec -u 0 $CONTNAME npm --prefix /var/www/html/$PROJNAME run dev /var/www/html/$PROJNAME
docker exec -u 0 $CONTNAME npm --prefix /var/www/html/$PROJNAME install vue /var/www/html/$PROJNAME
