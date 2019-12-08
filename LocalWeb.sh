#!/bin/bash

docker run --name cpweb -v c:/git:/var/www/html -v c:/USERS/TYRONS/.aws/credentials:/home/app/.aws/credentials:ro -d -p 80:80 devweb 
docker exec -u 0 cpweb update-ca-trust force-enable
docker cp c:/users/tyrons/docker/devweb/config/Stoddart_Group_Issuing_CA.cer cpweb:/etc/pki/ca-trust/source/anchors/
docker cp c:/users/tyrons/docker/devweb/config/Stoddart_Group_Offline_Root_CA.cer cpweb:/etc/pki/ca-trust/source/anchors/
docker exec -u 0 cpweb update-ca-trust extract