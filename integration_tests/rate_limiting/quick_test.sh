## for quick start

source ../common_functions.sh

export module=ratelimiting
export name=${module}_srv
export url=${upstream_url}
export hosts=${module}.org
export route_id=""
export consumerName=${module}_consumer
export consumer_id=''
export key=${consumerName}_secret_key


echo "Test X-RateLimit from the response"
curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}"

echo "Watch 'X-RateLimit-Remaining-hour: ' from the response"