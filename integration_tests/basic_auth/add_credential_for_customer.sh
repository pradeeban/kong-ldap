#!/bin/bash

source ../common_functions.sh

module=basicAuth
echo ">>>>>>>>> Adding API key: api_name=$apikey, customer=${consumer}_basic"
set -x
curl -i -X POST \
  --url ${kong_admin_url}/consumers/${consumer}_${module}/basic-auth \
  --data "username=${consumer}_${module}" \
  --data "password=${consumerPass}_${module}"
