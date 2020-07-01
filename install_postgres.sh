#!/bin/bash

## Start a PostgreSQL container by executing:
source ./env

docker run -d --name kong-database \
              -p 5432:5432 \
              -e "POSTGRES_USER=kong" \
              -e "POSTGRES_DB=kong" \
-e POSTGRES_HOST_AUTH_METHOD=trust \
              postgres:${POSTGRES_VERSION}


