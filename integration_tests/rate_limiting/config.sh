#!/usr/bin/env bash

# Rate limit how many HTTP requests a developer can make in a given period of seconds,
# minutes, hours, days, months or years. If the underlying Service/Route
# (or deprecated API entity) has no authentication layer, the Client IP address will be used,
# otherwise the Consumer will be used if an authentication plugin has been configured.

source ./env

#############################################################
echo "Adding Service: name=${name}, url=${url}"
serviceId=$(createService ${name} ${url})
echo "Created service Id: ${serviceId}"

sleep 3

#############################################################
echo "Add rate-limiting plugin on top of a Service ${name}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=rate-limiting"  \
      --data "config.second=5"       \
      --data "config.hour=10"

sleep 3

#############################################################
echo "Adding Route for service:${name} with hosts: ${hosts}"
route_id=$(createRoute ${name} ${hosts})
echo "Created route Id: ${route_id}"

sleep 3

#############################################################
echo "Enable rate-limiting plugin for Route "
curl -i -X POST \
      --url ${kong_admin_url}/routes/${route_id}/plugins       \
      --data "name=rate-limiting"  \
      --data "config.second=5" \
      --data "config.hour=10"

sleep 3

#############################################################
echo "Create a Consumer"
consumer_id=$(createConsumer ${consumerName})
echo "Created Consumer Id: ${consumer_id}"

sleep 3

#############################################################
echo "Enabling rate-limiting for Consumer ${consumerName}, consumer id: ${consumer_id}"
curl -i -X POST \
      --url ${kong_admin_url}/plugins    \
      --data "name=rate-limiting" \
      --data "consumer_id=${consumer_id}"  \
      --data "config.second=5" \
      --data "config.hour=10"

#############################################################
echo "To test: ./test.sh"

