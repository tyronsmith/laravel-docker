REM Pull, Run and Configure existing docker image from ECR registry (REPORITORY_URI property)
@ ECHO OFF
REM USER PROPERTIES START
set SOURCE_ROOT="C:/git/contractplus-web"
set PORT_MAPPING="80:80"
REM USER PROPERTIES END

REM TEMP file to hold ECR login command, will be deleted on exit
set ECR_LOGIN_FILE="ecr-login.bat"

REM Docker image to pull
set REPORITORY_URI="136029074619.dkr.ecr.ap-southeast-2.amazonaws.com/contractplus-web-docker"
set VERSION="1.0"

REM Container name for the local instance
set CONTAINER_NAME="stgweb"

ECHO Running %REPORITORY_URI%:%VERSION%...
aws ecr get-login --no-include-email > %ECR_LOGIN_FILE%

IF EXIST %ECR_LOGIN_FILE% (
	ECHO Calling %ECR_LOGIN_FILE%
	call %ECR_LOGIN_FILE%
	REM remove the container
	docker rm -f %CONTAINER_NAME%

	rem Run the container
	docker run --name %CONTAINER_NAME% -v %SOURCE_ROOT%:/var/www/html/contractplus-web -d -p %PORT_MAPPING% %REPORITORY_URI%:%VERSION%

	rem Install composer
	ECHO Install composer...
	docker exec -u 0 %CONTAINER_NAME% composer install -d /var/www/html/contractplus-web

	rem Update ca cert
	ECHO Update ca-trust trust...
	docker exec -u 0 %CONTAINER_NAME% update-ca-trust force-enable

	rem Copy ca certs
	ECHO Copy ca certificates...
	docker cp ./config/Stoddart_Group_Issuing_CA.cer %CONTAINER_NAME%:/etc/pki/ca-trust/source/anchors/  
	docker cp ./config/Stoddart_Group_Offline_Root_CA.cer %CONTAINER_NAME%:/etc/pki/ca-trust/source/anchors/

	rem Update ca trust
	ECHO Extract ca trust..
	docker exec -u 0 %CONTAINER_NAME% update-ca-trust extract
	
	ECHO Deleting %ECR_LOGIN_FILE% file...
	IF EXIST %ECR_LOGIN_FILE% DEL /F %ECR_LOGIN_FILE%
	ECHO Docker Run Successful.
) ELSE (
    ECHO %ECR_LOGIN_FILE% Not Found
	ECHO Docker Run Aborted!
)