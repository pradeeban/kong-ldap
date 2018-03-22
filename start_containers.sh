#!/bin/bash

## Remove kong related containers and their volumes
docker ps -a | grep kong | awk '{print $1}'  | xargs docker stop

##docker rm -vf kong-dashboard
##docker rm -vf kong
##docker rm -vf kong-migration
##docker rm -vf kong-database

docker ps -a |grep -i kong
