
#!/bin/bash

source ./env

set -x

echo "You should see 200 status code "
curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${hosts}" \
  --header "apikey: ${apiKey}"

echo "------------------------------"
echo "You should see 401 Unauthorized code and message: No API key found in request"
curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${hosts}"