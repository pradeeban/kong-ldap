
#!/bin/bash

source ${PWD}/common_functions.sh
set -x
curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${api_hosts}" \
  --header "apikey: ${apiKey}"
