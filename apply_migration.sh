#!/bin/bash
## Run the database migrations with an ephemeral Kong container:
## In the above example, both Cassandra and PostgreSQL are configured, 
## but you should update the KONG_DATABASE environment variable with 
## either cassandra or postgres.

## Note: migrations should never be run concurrently; 
## only one Kong node should be performing migrations at a time.

docker run --rm \
    --link kong-database:kong-database \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    kong:latest kong migrations up

