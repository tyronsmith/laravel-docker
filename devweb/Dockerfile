FROM centos:7 
 
MAINTAINER "CaptainAwesome" 
 
ENV container docker 
#SK: You can use variables from .env file anywhere in this file, if required e.g. $USER_HOME 
 
RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \ 
    yum-config-manager --enable remi-php72 
     
# normal updates 
RUN yum -y update 
 
# php && httpd 
RUN yum -y install php httpd php-cli php-pgsql php-pdo php-ldap php-intl php-zip php-xml php-mbstring ca-certificates gcc-c++ make libpng build-essential libpng-devel ghostscript 
 
# tools 
RUN yum -y install yum-utils epel-release iproute at curl crontabs 
 
# composer 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer 
 
# npm 
RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash 
RUN yum -y install nodejs 
 
# we want some config changes 
COPY config/v-host.conf /etc/httpd/conf.d/z-host.conf 
 
# create webserver-default directory 
RUN mkdir -p /var/www/html 
RUN mkdir -p /var/www/html/project 
 
RUN mkdir -p /var/www/html/project 
 
#SK: install AWSCLI (Reference: https://docs.aws.amazon.com/cli/latest/userguide/install-linux.html) 
RUN curl -O https://bootstrap.pypa.io/get-pip.py 
RUN python get-pip.py 
RUN pip install awscli 
 
#SK: create/maintain entrypoint script file or any other script files on the host and then copy to container image 
COPY entrypoint.sh /usr/local/bin/ 
RUN chmod +x /usr/local/bin/entrypoint.sh 
 
EXPOSE 80 81 
 
# SK: Check if this can be done in the entrypoint script file 
RUN systemctl enable httpd \ 
 && systemctl enable crond  
 
# SK: run/execute the entrypoint script on container startup 
CMD ["/bin/bash", "/usr/local/bin/entrypoint.sh"] 