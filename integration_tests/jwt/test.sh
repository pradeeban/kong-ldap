#!/usr/bin/env bash

source ./env

set -x
jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZWYxZmU2OTM3ZTQ0NGE2YjE4YTI2OTY1ZDYxOTcxOCIsImlhdCI6bnVsbCwiZXhwIjpudWxsLCJhdWQiOiIiLCJzdWIiOiIifQ.50bnA9d3wjIYIx6m-fzxIHQHfXF6zuJRPMUdk8-4LTU

echo "Test JWT from thresponse"
curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Authorization: Bearer ${jwt}" \
      --header "Host: ${hosts}"

exit

echo ""
echo "The plugin will append some headers to the request"
docker logs kong-backend
