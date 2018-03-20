#!/bin/bash

source ../common_functions.sh

echo ">>>>>>>>> Adding API key: api_name=$apikey, customer=${consumer}_basic"
set -x
curl -i -X POST \
  --url ${kong_admin_url}/consumers/${consumer}/basic-auth \
  --data "username=${consumer}" \
  --data "password=${consumerPass}"
