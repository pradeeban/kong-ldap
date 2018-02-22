
#!/bin/sh

source ${PWD}/common_functions.sh

curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${api_hosts}"
