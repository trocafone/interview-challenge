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