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

docker build -t openidentityplatform/opendj/ opendj
## start the container
##docker run --name ldap -d -p 389:10389 openmicroscopy/apacheds
docker run -h pradeebans-mbp.wireless.emory.edu -p 389:1389 -p 1636:1636 -p 4444:4444 --name kong-ldap openidentityplatform/opendj