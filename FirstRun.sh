#!/bin/bash

docker run --name devenv -v c:/git:/var/www/html -d -p 80:80 devweb 

# run composer install on ContractPlus Web
docker exec -u 0 devenv composer install -d /var/www/html/contractplus-web
docker exec -u 0 devenv composer update -d /var/www/html/contractplus-web

# install npm on ContractPlus Web and run the manager
docker exec -u 0 devenv npm --prefix /var/www/html/contractplus-web install /var/www/html/contractplus-web
docker exec -u 0 devenv npm --prefix /var/www/html/contractplus-web run dev /var/www/html/contractplus-web

docker exec -u 0 devenv update-ca-trust force-enable
docker cp c:/users/tyrons/docker/devweb/config/Stoddart_Group_Issuing_CA.cer devenv:/etc/pki/ca-trust/source/anchors/
docker cp c:/users/tyrons/docker/devweb/config/Stoddart_Group_Offline_Root_CA.cer devenv:/etc/pki/ca-trust/source/anchors/
docker exec -u 0 devenv update-ca-trust extract