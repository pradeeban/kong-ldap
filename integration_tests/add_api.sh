#!/bin/bash

source ${PWD}/common_functions.sh

echo ">>>>>>>>> Adding API: api_name=$api_name, api_hosts=$api_hosts"

curl -i -X POST \
  --url ${kong_admin_url}/apis/ \
  --data "name=${api_name}" \
  --data "hosts=${api_hosts}" \
  --data "upstream_url=${upstream_url}"
  
echo ""
echo ">>>>>>>> List all apis"
curl -i ${kong_admin_url}/apis
