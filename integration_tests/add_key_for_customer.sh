#!/bin/bash

source ${PWD}/common_functions.sh

echo ">>>>>>>>> Adding API key: api_name=$apikey, customer=$customer"
set -x
curl -i -X POST \
  --url ${kong_admin_url}/consumers/${consumer}/key-auth \
  --data "key=${apiKey}"
