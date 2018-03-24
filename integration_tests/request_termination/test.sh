#!/usr/bin/env bash
## for quick start


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

set -x

echo "Disable the backend service "
docker stop kong-backend

sleep 2

curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}"

echo "Start the backend service"
docker start kong-backend

sleep 10
docker ps |grep kong-backend

sleep 5
curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}"

sleep 3
curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}"