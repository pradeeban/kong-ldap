#!/bin/bash

echo "Stop kong related containers"
docker ps -a | grep kong | awk '{print $1}'  | xargs docker stop

docker ps -a |grep -i kong
