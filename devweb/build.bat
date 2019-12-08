REM Builds the image from the corresponding Dockerfile
REM To run/start a container from this image use 'run.bat'
@ ECHO OFF
REM IMAGE_NAME is same as ECR REPORITORY_NAME
set IMAGE_NAME="contractplus-web-docker"
REM Version given to this image locally at build time
set VERSION="latest"

ECHO Building %IMAGE_NAME%:%VERSION%...
docker build -t %IMAGE_NAME%:%VERSION% .	