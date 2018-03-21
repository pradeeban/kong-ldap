
#!/bin/bash

source ../common_functions.sh
set -x
## correct one
##credential=QWxhZGRpbjpPcGVuU2VzYW1l

credentialRaw=${consumer}:${consumerPass}
credential=$(../encoderBase64.sh $credentialRaw)

curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${api_hosts}" \
  --header "Authorization: Basic ${credential}"
