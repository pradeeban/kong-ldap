#!/usr/bin/env bash

source ./env

##########################################################
echo "Adding Service: name=${name}, url=${url}"
curl -i -X POST \
      --url ${kong_admin_url}/services/    \
      --data "name=${name}"                 \
      --data "url=${url}"

sleep 2

##########################################################
echo "Add JWT plugin on top of a Service ${name}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=jwt"

sleep 2

##########################################################
echo "Adding Route for service:${name} with hosts: ${hosts}"
route_id=$(createRoute ${name} ${hosts})
echo "route id is ${route_id}"

sleep 2

##########################################################
echo "Enable JWT plugin for Route "
curl -i -X POST \
      --url ${kong_admin_url}/routes/${route_id}/plugins       \
      --data "name=jwt"

sleep 2

##########################################################
echo "Create a Consumer"
consumer_id=$(createConsumer ${consumerName})
echo "consumer id is ${consumer_id}"

echo "Create a JWT credential for Consumer ${consumerName}, consumer id: ${consumer_id}"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/${consumer_id}/jwt \
      -d "secret=${secret}&algorithm=${algorithm}&key=${key}" \
      -H "Content-Type: application/x-www-form-urlencoded"

##########################################################
echo "To test: ./test.sh"