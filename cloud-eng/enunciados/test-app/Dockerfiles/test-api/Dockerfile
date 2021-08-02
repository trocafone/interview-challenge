############################################################
########################## BASE ############################
############################################################

# Defining base image
FROM ubuntu:20.10 as base

# Define Environment Variables
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ARG DEBIAN_FRONTEND=noninteractive

# Update Repositories
RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y --no-install-recommends nginx \
                                                  curl

############################################################
######################### WORKER ###########################
############################################################

FROM base AS worker

RUN apt-get update \
    && apt-get install -y redis-tools \
                          postgresql-client

############################################################
########################### api ############################
############################################################

FROM worker AS api

# Add and Update Repositories for PHP

RUN apt-get install -y software-properties-common
RUN apt-get update \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends php7.4 \
                                                  php7.4-fpm \
                                                  php7.4-pgsql

# Clean packages installers

COPY nginx/sites-available /etc/nginx/sites-available
COPY php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /var/log/nginx \
    && mkdir -p /tmp/logs \
    && touch /run/nginx.pid

WORKDIR /var/app
