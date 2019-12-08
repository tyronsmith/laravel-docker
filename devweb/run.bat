REM Run locally build image from build.bat
@ ECHO OFF
REM USER PROPERTIES START
set SOURCE_ROOT="C:/git/contractplus-web"
set PORT_MAPPING="80:80"

REM Image to run - this must be same as build.bat 
set IMAGE_NAME="contractplus-web-docker"
set VERSION="latest"

REM Container name for the local instance of the image - must be unique
set CONTAINER_NAME="stgweb"
REM USER PROPERTIES END

ECHO Running %IMAGE_NAME%:%VERSION%...

REM remove the container - it will remove it exist otherwise just give warning!
docker rm -f %CONTAINER_NAME%

REM Run the container
docker run --name %CONTAINER_NAME% -v %SOURCE_ROOT%:/var/www/html/contractplus-web -d -p %PORT_MAPPING% %IMAGE_NAME%:%VERSION%

REM Install composer
ECHO Install composer...
docker exec -u 0 %CONTAINER_NAME% composer install -d /var/www/html/contractplus-web

REM Update ca cert
ECHO Update ca-trust trust...
docker exec -u 0 %CONTAINER_NAME% update-ca-trust force-enable

REM Copy ca certs
ECHO Copy ca certificates...
docker cp ./config/Stoddart_Group_Issuing_CA.cer %CONTAINER_NAME%:/etc/pki/ca-trust/source/anchors/  
docker cp ./config/Stoddart_Group_Offline_Root_CA.cer %CONTAINER_NAME%:/etc/pki/ca-trust/source/anchors/

REM Update ca trust
ECHO Extract ca trust..
docker exec -u 0 %CONTAINER_NAME% update-ca-trust extract

ECHO Docker Run Successful.
