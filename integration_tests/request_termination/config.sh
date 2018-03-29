#!/usr/bin/env bash

# This plugin terminates incoming requests with a specified status code and message.
# his allows to (temporarily) stop traffic on a Service or a Route
# (or the deprecated API entity), or even block a Consumer.


source ./env

#############################################################
echo "Adding Service(API): name=${name}, url=${url}"
serviceId=$(createService ${name} ${url})
echo "Created service Id: ${serviceId}"

sleep 2

#############################################################
echo "Add request-termination plugin on top of a Service ${name}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=request-termination"  \
      --data "config.status_code=403" \
      --data "config.message=${message}"

sleep 2
#############################################################
echo "Adding Route for service:${name} with hosts: ${hosts}"
route_id=$(createRoute ${name} ${hosts})
echo "Created route Id: ${route_id}"

sleep 2

#############################################################
echo "Enable request-termination plugin for Route "
curl -i -X POST \
      --url ${kong_admin_url}/routes/${route_id}/plugins       \
      --data "name=request-termination"  \
      --data "config.status_code=403" \
      --data "config.message=${message}"

sleep 2
#############################################################
echo "Create a Consumer"
consumer_id=$(createConsumer ${consumerName})
echo "Created Consumer Id: ${consumer_id}"

sleep 2

#############################################################
echo "Enabling request-termination for Consumer ${consumerName}, consumer id: ${consumer_id}"
curl -i -X POST \
      --url ${kong_admin_url}/plugins    \
      --data "name=request-termination" \
      --data "consumer_id=${consumer_id}"  \
      --data "config.status_code=403" \
      --data "config.message=${message}"

sleep 2

#############################################################
set -x
curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}"


echo ""
echo "Disable the backend service "
docker stop kong-backend

sleep 2

curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}"


