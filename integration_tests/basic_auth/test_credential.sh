
#!/bin/bash

source ../common_functions.sh
set -x
## correct one
##credential=QWxhZGRpbjpPcGVuU2VzYW1l
module=basicauth
credentialRaw=${consumer}_${module}:${consumerPass}_${module}
credential=$(../encoderBase64.sh $credentialRaw)

curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${api_hosts}_${module}" \
  --header "Authorization: Basic ${credential}"
