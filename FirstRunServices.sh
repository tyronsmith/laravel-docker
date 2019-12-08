#!/bin/bash

# run composer install on Services
docker exec -u 0 devenv composer install -d /var/www/html/services
docker exec -u 0 devenv composer update -d /var/www/html/services

# install npm on Services and run the manager
docker exec -u 0 devenv npm --prefix /var/www/html/services install /var/www/html/contractplus-web
docker exec -u 0 devenv npm --prefix /var/www/html/services run dev /var/www/html/contractplus-web