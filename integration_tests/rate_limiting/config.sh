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

echo "Input route id (id from the previous response), followed by [ENTER]:"
route_id=$(getUserInput)
echo "route id is ${route_id}"

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

echo "Input consumer id (id from the previous response), followed by [ENTER]:"
consumer_id=$(getUserInput)
echo "consumer id is ${consumer_id}"

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
