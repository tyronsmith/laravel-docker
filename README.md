# laravel-docker
Docker Environment for Laravel

Built on Centos running;
* Apache
* PHP 7.2

To Run
Firstly, edit the v-host.conf file and put in your project name. This needs to match the project name you use below.

Execute the Setup.sh file to build the docker image and then start the container.
This script expects 3 variables;
	* Setup.sh contname="<containerName>" project="<yourProjectName>" repo="<locationOfYourRepoWithProject" 
	
This execution will;
	* Mount your repo location to the container.
	* Run composer install on your project folder in the container.
	* Run npm install on your project folder in the container.
	
Once built and running, you need to remember to mount your drive if you kill the container and need to restart it.
	* docker run --name $CONTNAME -v $REPOSITORY:/var/www/html -d -p 80:80 laravel