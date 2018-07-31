#!/bin/bash

##  Once the database has been started and prepared,
## we can start a Kong container and link it to the database container,
## and configuring the KONG_DATABASE environment variable with
## either cassandra or postgres depending on which database
## you decided to use:

source ./env

##--link kong-ldap:kong-ldap \
 ## docker run -d --name kong \
 docker run  --name kong \
    --link kong-database:kong-database \
    --link kong-ldap:kong-ldap \
    --link kong-backend:kong-backend \
    -e "KONG_LOG_LEVEL=info" \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
    -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
    -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
    -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
    -e "KONG_ADMIN_LISTEN=0.0.0.0:8001" \
    -e "KONG_ADMIN_LISTEN_SSL=0.0.0.0:8444" \
    -p 8000:8000 \
    -p 8443:8443 \
    -p 8001:8001 \
    -p 8444:8444 \
    kong:${KONG_VERSION}
