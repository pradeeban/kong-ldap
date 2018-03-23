
#!/bin/bash

source ../common_functions.sh
source ./config.sh
set -x

curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${hosts}"
