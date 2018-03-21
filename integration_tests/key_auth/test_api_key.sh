
#!/bin/bash

source ../common_functions.sh
set -x
module=keyAuth
curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${api_hosts}_${module}" \
  --header "apikey: ${apiKey}_${module}"
