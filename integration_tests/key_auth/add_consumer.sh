#!/bin/bash

source ../common_functions.sh

module=keyauth
echo ">>>>>>>>> Adding customer: username=${consumer}_${module}"

curl -i -X POST \
  --url ${kong_admin_url}/consumers/ \
  --data "username=${consumer}_${module}" \
  --data "custom_id=${consumer}_${module}_id"
