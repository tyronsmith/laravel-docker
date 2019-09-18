#!/bin/bash

docker build -t laravel:latest .

docker run --name $CONTAINER -v $SOURCELOC:/var/www/html -d -p 80:80 laravel 

# run composer install on project folder
docker exec -u 0 $CONTAINER composer install -d /var/www/html/project
docker exec -u 0 $CONTAINER composer update -d /var/www/html/project

# install npm on project folder and run the manager
docker exec -u 0 $CONTAINER npm --prefix /var/www/html/project install /var/www/html/project
docker exec -u 0 $CONTAINER npm --prefix /var/www/html/project run dev /var/www/html/project
