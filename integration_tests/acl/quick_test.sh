## for quick start

source ../common_functions.sh
export module=acl
export name=${module}_srv
export url=${upstream_url}
export hosts=${module}.org
export route_id=""
export consumerName=${module}_consumer
export key=${consumerName}_secret_key


echo "Verify that valid Consumer Credential are valid"
curl -X GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}" \
      --header "apikey: ${key}"

echo "You should see 'Backend Resource Response ...' message"
echo ""


echo "Verify that valid Consumer Credential are Not valid"
curl -X GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}" \
      --header "apikey: ${key}_bad"

echo "You should see 'You cannot consume this service' message"