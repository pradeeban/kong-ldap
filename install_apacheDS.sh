#!/bin/bash

## https://hub.docker.com/r/openmicroscopy/apacheds/
## You can manage the ldap server with the admin user uid=admin,ou=system and the default password secret.
## The default instance comes with a pre-configured partition dc=openmicroscopy,dc=org.
## An indivitual admin password should be set following this manual.
## Then you can import entries into that partition via your own ldif file:
## ldapadd -v -h <your-docker-ip>:389 -c -x -D uid=admin,ou=system -w <your-admin-password> -f sample.ldif

## pull from docker hub
##docker pull openmicroscopy/apacheds

## build, one time only
##git clone https://github.com/openmicroscopy/apacheds-docker.git

source ./env

docker build -t openmicroscopy/apacheds apacheds-docker

## start the container
##docker run --name ldap -d -p 389:10389 openmicroscopy/apacheds
docker run --name kong-ldap -d  -p 389:10389 openmicroscopy/apacheds
