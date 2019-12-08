#!/bin/bash

docker run --name services -v c:/git:/var/www/html -v c:/USERS/TYRONS/.aws/credentials:/home/app/.aws/credentials:ro -d -p 81:81 devweb 
docker exec -u 0 services update-ca-trust force-enable
docker cp c:/users/tyrons/docker/devweb/config/Stoddart_Group_Issuing_CA.cer services:/etc/pki/ca-trust/source/anchors/
docker cp c:/users/tyrons/docker/devweb/config/Stoddart_Group_Offline_Root_CA.cer services:/etc/pki/ca-trust/source/anchors/
docker exec -u 0 services update-ca-trust extract