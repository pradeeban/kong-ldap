#!/bin/bash

source ./env

set -x

credentialRaw=${consumerUserName}:${consumerUserNamePass}
credential=$(../encoderBase64.sh ${credentialRaw})
set -x
curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${hosts}" \
  --header "Authorization: Basic ${credential}"
