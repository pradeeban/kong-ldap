#!/bin/bash

source ../common_functions.sh

module=oauth2Auth
echo ">>>>>>>>> Adding API: api_name=${api_name}_${module}, api_hosts=${api_hosts}_${module}"


set -x


curl -i -X POST \
  --url ${kong_admin_url}/apis/ \
  --data "name=cats" \
  --data "uris=/cats" \
  --data "upstream_url=http://mockbin.org/" \
  --data "preserve_host=false"



