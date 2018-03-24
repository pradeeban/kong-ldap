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

set -x
jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZWYxZmU2OTM3ZTQ0NGE2YjE4YTI2OTY1ZDYxOTcxOCIsImlhdCI6bnVsbCwiZXhwIjpudWxsLCJhdWQiOiIiLCJzdWIiOiIifQ.50bnA9d3wjIYIx6m-fzxIHQHfXF6zuJRPMUdk8-4LTU

echo "Test JWT from thresponse"
curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Authorization: Bearer ${jwt}" \
      --header "Host: ${hosts}"


echo ""
echo "The plugin will append some headers to the request"
docker logs kong-backend
