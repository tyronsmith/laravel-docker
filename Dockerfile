FROM centos:7

MAINTAINER "CaptainAwesome"

ENV container docker

RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum-config-manager --enable remi-php72
	
# normal updates
RUN yum -y update

# php && httpd
RUN yum -y install php httpd php-cli php-pgsql php-pdo php-ldap php-intl php-zip php-xml php-mbstring ca-certificates gcc-c++ make libpng build-essential libpng-devel ghostscript php-bcmath redis php-nrk-Predis

# tools
RUN yum -y install yum-utils epel-release iproute at curl crontabs

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# npm
RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash
RUN yum -y install nodejs

# we want some config changes
COPY config/v-host.conf /etc/httpd/conf.d/z-host.conf

COPY config/informed_365_db_prod_20191205_1610.dump /home/informed365.dump
#RUN psql informed_365_db < /home/informed365.dump

# create webserver-default directory
RUN mkdir -p /var/www/html
	
EXPOSE 80 81 6379

RUN systemctl enable httpd \
 && systemctl enable crond 

CMD ["/usr/sbin/httpd", "-DFOREGROUND"]