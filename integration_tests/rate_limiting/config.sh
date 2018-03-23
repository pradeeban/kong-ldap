#!/usr/bin/env bash

# Rate limit how many HTTP requests a developer can make in a given period of seconds,
# minutes, hours, days, months or years. If the underlying Service/Route
# (or deprecated API entity) has no authentication layer, the Client IP address will be used,
# otherwise the Consumer will be used if an authentication plugin has been configured.

source ../common_functions.sh

export module=ratelimiting
export name=${module}_srv
export url=${upstream_url}
export hosts=${module}.org
export route_id=""
export consumerName=${module}_consumer
export consumer_id=''
export key=${consumerName}_secret_key

echo "Adding Service: name=${name}, url=${url}"
curl -i -X POST \
      --url ${kong_admin_url}/services/    \
      --data "name=${name}"                 \
      --data "url=${url}"


echo "Add rate-limiting plugin on top of a Service ${name}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=rate-limiting"  \
      --data "config.second=5"       \
      --data "config.hour=100"


echo "Adding Route for service:${name} with hosts: ${hosts}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/routes    \
      --data "hosts[]=${hosts}"

if [ -z "$route_id" ]
then

      echo "Input route id (id from the previous response), followed by [ENTER]:"
      read route_id
      echo "routeId is ${route_id}"
else
      echo "route id ${route_id}"
fi

echo "Enable rate-limiting plugin for Route "
curl -i -X POST \
      --url ${kong_admin_url}/routes/${route_id}/plugins       \
      --data "name=rate-limiting"  \
      --data "config.second=5" \
      --data "config.hour=100"


echo "Create a Consumer"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/         \
      --data "username=${consumerName}"          \
      --data "custom_id=${consumerName}_id"

if [ -z "$consumer_id" ]
then

      echo "Input consumer id (id from the previous response), followed by [ENTER]:"
      read consumer_id
      echo "consumer is ${consumer_id}"
else
      echo "consumer id ${consumer_id}"
fi

echo "Enabling rate-limiting for Consumer ${consumerName}, consumer id: ${consumer_id}"
curl -i -X POST \
      --url ${kong_admin_url}/plugins    \
      --data "name=rate-limiting" \
      --data "consumer_id=${consumer_id}"  \
      --data "config.second=5" \
      --data "config.hour=100"

echo "Test X-RateLimit from the response"
curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}"

echo "Watch 'X-RateLimit-Remaining-hour: ' from the response"
