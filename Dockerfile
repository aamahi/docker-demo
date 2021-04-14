FROM ubuntu

#  Update package manager
RUN apt-get update && \
    apt-get -y install sudo

ARG DEBIAN_FRONTEND=noninteractive

# Enabling PHP Repository
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php

# Install PHP8 
RUN apt-get install -y php8.0

# Configure and install apache2
RUN apt-get update
RUN apt-get install -y apache2
RUN mkdir -p /var/lock/apache2
RUN mkdir -p /var/run/apache2

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV LANG C


# Working Derectior
WORKDIR /var/www

# Installing Node Dependencies
RUN apt-get install nodejs -y

# Apache foregroud 
CMD ["/usr/sbin/apache2","-D","FOREGROUND"]

# expose port 80 and 443
EXPOSE 443
EXPOSE 80

# Change current user to root
USER root