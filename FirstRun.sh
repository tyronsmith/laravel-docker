#!/bin/bash
docker build . -t laravel:latest
docker run --name informed -v d:/git/laravel-api:/var/www/html/project -d -p 80:80 laravel
docker exec -u 0 informed composer install -d /var/www/html/project
docker exec -u 0 informed composer update -d /var/www/html/project
docker exec -u 0 informed php /var/www/html/project/artisan migrate

docker run --name informed-postgres -e POSTGRES_PASSWORD= -d postgres
docker cp d:/git/informed_365_db_prod_20191205_1610.dump informed-postgres:/home/informed365.dump
#docker exec informed-postgres -u postgres createuser informed365_db_user
docker exec -u postgres informed-postgres psql -c 'create user informed365_db_user'
docker exec -u postgres informed-postgres psql -c 'CREATE DATABASE informed_365_db;'
docker exec informed-postgres pg_restore -U postgres -d informed_365_db -n informed_365_db /home/informed365.dump


# install npm on ContractPlus Web and run the manager
docker exec -u 0 devenv npm --prefix /var/www/html/contractplus-web install /var/www/html/contractplus-web
docker exec -u 0 devenv npm --prefix /var/www/html/contractplus-web run dev /var/www/html/contractplus-web

docker exec -u 0 devenv update-ca-trust force-enable
docker cp c:/users/tyrons/docker/devweb/config/Stoddart_Group_Issuing_CA.cer devenv:/etc/pki/ca-trust/source/anchors/
docker cp c:/users/tyrons/docker/devweb/config/Stoddart_Group_Offline_Root_CA.cer devenv:/etc/pki/ca-trust/source/anchors/
docker exec -u 0 devenv update-ca-trust extract

docker exec -u 0 informed pg_restore -U postgres -d informed_365_db /home/informed365.dump



docker exec -u postgres informed-postgres psql -d informed_365_db -c 'SELECT * FROM pg_catalog.pg_tables'

