#!/bin/bash

source ./env

#############################################################
echo "Adding Service(API): name=${name}, url=${url}"
serviceId=$(createService ${name} ${url})
echo "Created service Id: ${serviceId}"

sleep 3

#############################################################
echo "Enabling the plugin for a Service ${name}, id=${serviceId}"

curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=basic-auth"  \
      --data "config.hide_credentials=true"

sleep 3

#############################################################
echo "Adding Route for service:${name} with hosts: ${hosts}"
routeId=$(createRoute ${name} ${hosts})
echo "Created route Id: ${routeId}"

sleep 3

#############################################################
echo "Enabling the plugin for a RouteId: ${routeId}"
curl -i -X POST \
      --url ${kong_admin_url}/routes/${routeId}/plugins \
      --data "name=basic-auth"  \
      --data "config.hide_credentials=true"

sleep 3
#############################################################
echo "Create a Consumer"
consumerId=$(createConsumer ${consumerName})
echo "Created Consumer Id: ${consumerId}"

sleep 3

#############################################################
echo "Create a Credential for Consumer: ${consumerName}"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/${consumerName}/basic-auth \
      --data "username=${consumerUserName}" \
      --data "password=${consumerUserNamePass}"

sleep 3

#############################################################
echo "To test: run ./test.sh"