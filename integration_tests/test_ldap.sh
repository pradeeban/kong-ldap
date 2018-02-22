#!/bin/sh

source ${PWD}/common_functions.sh
credentials_raw="agu:secret"
credentials=$(encoderBase64.sh $credentials_raw)

echo "   credentials_raw=$credentials_raw"
echo "credentials_base64=$credentials"
echo ""
set -x
curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${api_hosts}" \
  --header "Authorization: credentials := ldap ${credentials}"
