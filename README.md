# laravel-docker
Docker Environment for Laravel

Built on Centos running;
* Apache
* PHP 7.2

To Run
Execute the Setup.sh file to build the docker image and then start the container.
This script expects 3 variables;
	* Setup.sh contname="<containerName>" project="<yourProjectName>" repo="<locationOfYourRepoWithProject" 
	
This execution will;
	* Mount the repo location to the container.
	* Run composer install on your project folder in the container.
	* Run npm install on your project folder in the container.