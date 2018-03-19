#!/bin/bash

## Start Kong Dashboard
## Error: Could not reach Kong on http://kong:8001
## docker run --rm -p 8080:8080 pgbi/kong-dashboard start --kong-url http://kong:8001
##docker run  --name kong-dashboard -p 8080:8080 pgbi/kong-dashboard:v2

##docker run  --name kong-dashboard -p 8080:8080 --link kong:kong pgbi/kong-dashboard:v3.1.0

# Start Kong Dashboard on a custom port
##docker run --rm -p [port]:8080 pgbi/kong-dashboard start --kong-url http://kong:8001

# Start Kong Dashboard with basic auth
##docker run --rm -p 8080:8080 pgbi/kong-dashboard start \
##  --kong-url http://kong:8001
####  --basic-auth user1=password1 user2=password2

# See full list of start options
####docker run --rm -p 8080:8080 pgbi/kong-dashboard start --help

## this one works
## docker run -d --name kong-dashboard -p 8080:8080 --link kong:kong pgbi/kong-dashboard:v2

docker run --link kong:kong -d --name kong-dashboard  --rm -p 8080:8080 pgbi/kong-dashboard start --kong-url http://kong:8001
docker ps -a |grep kong
