#!/bin/bash

source ../common_functions.sh

echo ">>>>>>>>> Adding customer: username=$consumer"

curl -i -X POST \
  --url ${kong_admin_url}/consumers/ \
  --data "username=${consumer}" \
  --data "custom_id=${consumer}_id"
