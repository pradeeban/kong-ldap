#!/bin/bash

echo "Remove all kong related containers and their volumes..."
./delete_containers.sh

echo "Install Postgres......................................."
./install_postgres.sh

echo "Wait for Postgres Build and Start......................"
sleep 6

echo "Apply Database Migration..."
./apply_migration.sh
sleep 10

echo "Build, Run and Start Kong in Interactive Mode..........."
./install_kong.sh

