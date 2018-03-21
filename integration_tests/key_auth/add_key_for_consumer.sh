#!/bin/bash

source ../common_functions.sh
module=keyAuth
echo ">>>>>>>>> Adding API key: api_name=$apikey, customer=${consumer}_${module}"
set -x
curl -i -X POST \
  --url ${kong_admin_url}/consumers/${consumer}_${module}/key-auth \
  --data "key=${apiKey}_${module}"
