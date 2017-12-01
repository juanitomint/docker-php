FROM php:7-apache
# APT proxy for faster install uses apt-cacher-ng instance
COPY config/20proxy.conf /etc/apt/apt.conf.d/

RUN apt update && \
    apt install -y git libssl-dev libxml2-dev libpng-dev && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin

RUN docker-php-ext-install soap &&\
    docker-php-ext-install mysqli &&\
    docker-php-ext-install pdo_mysql  &&\
    docker-php-ext-install bcmath && \
    docker-php-ext-install gd  &&\
    docker-php-ext-install zip && \
    pecl install xdebug && \
    pecl install mongodb

#COPY php /usr/local/etc/php
COPY apache2/apache2.conf /etc/apache2/apache2.conf


RUN a2enmod rewrite 