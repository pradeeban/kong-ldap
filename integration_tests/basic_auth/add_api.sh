#!/bin/bash

source ../common_functions.sh

module=basicauth
echo ">>>>>>>>> Adding API: api_name=${api_name}_${module}, api_hosts=${api_hosts}_${module}"

set -x
curl -i -X POST \
  --url ${kong_admin_url}/apis/ \
  --data "name=${api_name}_${module}" \
  --data "hosts=${api_hosts}_${module}" \
  --data "upstream_url=${upstream_url}" \
  --data "strip_uri=true" \
  --data "preserve_host=false"

echo ""
echo ">>>>>>>> List all apis"
curl -i ${kong_admin_url}/apis
