#!/usr/bin/env bash

# This plugin terminates incoming requests with a specified status code and message.
# his allows to (temporarily) stop traffic on a Service or a Route
# (or the deprecated API entity), or even block a Consumer.


source ../common_functions.sh

export module=requesttermination
export name=${module}_srv
export url=${upstream_url}
export hosts=${module}.org
export route_id=""
export consumerName=${module}_consumer
export consumer_id=''
export key=${consumerName}_secret_key
export message="Under Maintenance...!"

echo "Adding Service: name=${name}, url=${url}"
curl -i -X POST \
      --url ${kong_admin_url}/services/    \
      --data "name=${name}"                 \
      --data "url=${url}"


echo "Add request-termination plugin on top of a Service ${name}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=request-termination"  \
      --data "config.status_code=403" \
      --data "config.message=${message}"

echo "Adding Route for service:${name} with hosts: ${hosts}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/routes    \
      --data "hosts[]=${hosts}"

echo "Input route id (id from the previous response), followed by [ENTER]:"
route_id=$(getUserInput)
echo "route id is ${route_id}"

echo "Enable request-termination plugin for Route "
curl -i -X POST \
      --url ${kong_admin_url}/routes/${route_id}/plugins       \
      --data "name=request-termination"  \
      --data "config.status_code=403" \
      --data "config.message=${message}"


echo "Create a Consumer"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/         \
      --data "username=${consumerName}"          \
      --data "custom_id=${consumerName}_id"

echo "Input consumer id (id from the previous response), followed by [ENTER]:"
consumer_id=$(getUserInput)
echo "consumer id is ${consumer_id}"

echo "Enabling request-termination for Consumer ${consumerName}, consumer id: ${consumer_id}"
curl -i -X POST \
      --url ${kong_admin_url}/plugins    \
      --data "name=request-termination" \
      --data "consumer_id=${consumer_id}"  \
      --data "config.status_code=403" \
      --data "config.message=${message}"


echo "Disable the backend service "
docker stop kong-backend

sleep 2

curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}"

echo "Start the backend service"
docker start kong-backend

sleep 4
curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}"

