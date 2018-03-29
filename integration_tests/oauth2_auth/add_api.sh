#!/bin/bash

source ../common_functions.sh

module=oauth2auth
echo ">>>>>>>>> Adding API: api_name=${api_name}_${module}, api_hosts=${api_hosts}_${module}"


set -x

## Note: do not add hosts, otherwise, it won't wokk
## --data "hosts=mockbin.org" \

curl -i -X POST \
  --url ${kong_admin_url}/apis/ \
  --data "name=cats" \
  --data "uris=/cats" \
  --data "hosts=mockbin.org" \
  --data "upstream_url=http://mockbin.org/" \
  --data "preserve_host=false"



