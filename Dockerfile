FROM ubuntu:16.04

LABEL maintainer="Venuugopan Subramaniam <venuugopan@gmail.com>"

USER root

# Fish Nano Vim
RUN apt-get update 
RUN apt-get -y install fish
RUN apt-get -y install nano
RUN apt-get -y install vim

# NodeJS - NPM  - Grunt
RUN apt-get update
RUN apt-get -y install curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install nodejs
RUN npm install


#PHP 7.1 
RUN apt-get update \
    && apt-get -y install apache2 \
    && a2enmod rewrite \
    && a2enmod headers \
    && export LANG=en_US.UTF-8 \
    && apt-get update \
    && apt-get install -y software-properties-common \
    && apt-get install -y language-pack-en-base \
    && LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get -y install php7.1 php7.1-bcmath php7.1-cli php7.1-dev php7.1-gd php7.1-json php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-soap php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip  php-curl php7.1-intl \
    && sed -i -e"s/^memory_limit\s*=\s*128M/memory_limit = 1024M/" /etc/php/7.1/apache2/php.ini \
    && rm /var/www/html/* \
    && sed -i "s/None/all/g" /etc/apache2/apache2.conf 

#Composer
RUN apt-get update
RUN apt-get -y install composer


env APACHE_RUN_USER    www-data
env APACHE_RUN_GROUP   www-data
env APACHE_PID_FILE    /var/run/apache2.pid
env APACHE_RUN_DIR     /var/run/apache2
env APACHE_LOCK_DIR    /var/lock/apache2
env APACHE_LOG_DIR     /var/log/apache2
env LANG               C

WORKDIR /var/www/html

