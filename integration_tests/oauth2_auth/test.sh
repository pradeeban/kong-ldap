#!/usr/bin/env bash


source ../common_functions.sh

export module=oauth2
export name=${module}_srv
export url=${upstream_url}
export hosts=${module}.org
export consumerName=${module}_consumer
export client_id=${module}_client
export client_secret=${client_id}_secret
export client_app_name=${module}_client

echo "Input provision_key from the previous response, followed by [ENTER]:"
provision_key=$(getUserInput)
echo "provision_key is ${provision_key}"

echo ""

##  Get authorization code
curl https://localhost:8443/oauth2/authorize \
    --header "Host: ${hosts}" \
    --data "client_id=${client_id}" \
    --data "response_type=code" \
    --data "scope=email address" \
    --data "authenticated_userid=userid123"  \
    --data "provision_key=${provision_key}" \
    --insecure

echo ""

echo "Input code from the previous response, followed by [ENTER]:"
code=$(getUserInput)
echo "code=${code}"

curl https://localhost:8443/oauth2/token \
     --header "Host: ${hosts}" \
     -d "grant_type=authorization_code" \
     -d "client_id=${client_id}" \
     -d "client_secret=${client_secret}" \
     -d "redirect_uri=${url}/" \
     -d "code=${code}" \
     --insecure
