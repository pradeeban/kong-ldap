#!/usr/bin/env bash


source ../common_functions.sh

export module=jwt
export name=${module}_srv
export url=${upstream_url}
export hosts=${module}.org
export consumerName=${module}_consumer
##export key=${consumerName}_key
##export secret=${consumerName}_secret
##export algorithm=HS256

export key=cef1fe6937e444a6b18a26965d619718
export secret=b9f813fb8753440eabb1b44f9ba4da2f
export algorithm=HS256

echo "Adding Service: name=${name}, url=${url}"
curl -i -X POST \
      --url ${kong_admin_url}/services/    \
      --data "name=${name}"                 \
      --data "url=${url}"

echo "Add JWT plugin on top of a Service ${name}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=jwt"

echo "Adding Route for service:${name} with hosts: ${hosts}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/routes    \
      --data "hosts[]=${hosts}"

echo "Input route id (id from the previous response), followed by [ENTER]:"
route_id=$(getUserInput)
echo "route id is ${route_id}"

echo "Enable JWT plugin for Route "
curl -i -X POST \
      --url ${kong_admin_url}/routes/${route_id}/plugins       \
      --data "name=jwt"

echo "Create a Consumer"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/         \
      --data "username=${consumerName}"          \
      --data "custom_id=${consumerName}_id"

echo "Input consumer id (id from the previous response), followed by [ENTER]:"
consumer_id=$(getUserInput)
echo "consumer id is ${consumer_id}"

echo "Create a JWT credential for Consumer ${consumerName}, consumer id: ${consumer_id}"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/${consumer_id}/jwt \
      -d "secret=${secret}&algorithm=${algorithm}&key=${key}" \
      -H "Content-Type: application/x-www-form-urlencoded"

