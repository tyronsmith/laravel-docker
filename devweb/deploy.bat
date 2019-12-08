REM Deploys existing image (built from build.bat) to ECR Registry (REPOSITORY_URI) after tagging it.
@ ECHO OFF

REM IMAGE_NAME is same as REPORITORY_NAME
set IMAGE_NAME="contractplus-web-docker"
REM Repository URI for the image - this is where it will get deployed - repository must exist
set REPOSITORY_URI="136029074619.dkr.ecr.ap-southeast-2.amazonaws.com/%IMAGE_NAME%"

REM IMAGE VERSION for Tagging the image - this will be the version of the image when deployed. //This can be substituted with a build id from CI pipeline!
set VERSION="1.0"

REM TEMP file to hold ECR login command, will be deleted on exit
set ECR_LOGIN_FILE="ecr-login.bat"

ECHO Starting ECR Deploy...
aws ecr get-login --no-include-email > %ECR_LOGIN_FILE%

IF EXIST %ECR_LOGIN_FILE% (
	ECHO Loggin to ECR...
	call %ECR_LOGIN_FILE%
	ECHO Tagging the image %IMAGE_NAME%:latest to %REPOSITORY_URI%:%VERSION%...
	docker tag %IMAGE_NAME%:latest %REPOSITORY_URI%:%VERSION%
	ECHO Pushing the image...
	docker push %REPOSITORY_URI%:%VERSION%	
	ECHO Deleting %ECR_LOGIN_FILE% file...
	IF EXIST %ECR_LOGIN_FILE% DEL /F %ECR_LOGIN_FILE%
	ECHO ECR Deploy Successful.
) ELSE (
    ECHO %ECR_LOGIN_FILE% Not Found
	ECHO ECR Deploy Aborted!
)


