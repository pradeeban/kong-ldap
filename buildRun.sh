#!/bin/bash

source ./env

echo  "POSTGRES_VERSION=$POSTGRES_VERSION"
echo " KONG_VERSION=$KONG_VERSION"

echo "Remove all kong related containers and their volumes..."
 ./delete_containers.sh

##echo "Stop all kong related containers......................."
##./stop_containers.sh


echo "Start backend service hello world"
./install_backend.sh

#echo "Start Apache Active Directory Server................."
#./install_apacheDS.sh

sleep 4

echo "Install Postgres......................................."
./install_postgres.sh

echo "Wait for Postgres Build and Start......................"
sleep 6

echo "Apply Database Migration..."
./install_migration.sh
sleep 10

echo "Build, Run and Start Kong in Interactive Mode..........."
./install_kong.sh
