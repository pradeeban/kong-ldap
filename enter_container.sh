#!/bin/bash

container=$*
echo "Enter container $container with bash shell"
docker exec -it ${container} sh
