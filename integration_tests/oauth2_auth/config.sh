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

echo "Adding Service: name=${name}, url=${url}"
curl -i -X POST \
      --url ${kong_admin_url}/services/    \
      --data "name=${name}"                 \
      --data "url=${url}"

echo "Add OAuth2 plugin on top of a Service ${name}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=oauth2"  \
      --data "config.scopes=email,phone,address" \
      --data "config.mandatory_scope=true" \
      --data "config.enable_authorization_code=true"

echo "Input provision_key from the previous response, followed by [ENTER]:"
provision_key=$(getUserInput)
echo "provision_key is ${provision_key}"

echo "Adding Route for service:${name} with hosts: ${hosts}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/routes    \
      --data "hosts[]=${hosts}"

echo "Create a Consumer"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/         \
      --data "username=${consumerName}"          \
      --data "custom_id=${consumerName}_id"

echo "Input consumer id (id from the previous response), followed by [ENTER]:"
consumer_id=$(getUserInput)
echo "consumer id is ${consumer_id}"

echo "Create a OAuth2 Client Application for Consumer ${consumerName}, consumer id: ${consumer_id}"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/${consumer_id}/oauth2  \
      --data "name=${client_app_name}" \
      --data "client_id=${client_id}" \
      --data "client_secret=${client_secret}" \
      --data "redirect_uri=${url}/"


echo "Check client"
curl ${kong_admin_url}/oauth2?client_id=${client_id}

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
