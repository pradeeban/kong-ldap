#!/bin/bash

## You need to associate a credential to an existing Consumer 
## object, that represents a user consuming the API. 
source ../common_functions.sh

echo ">>>>>>>>> Adding customer: username=${consumer}"

curl -i -X POST \
  --url ${kong_admin_url}/consumers/ \
  --data "username=${consumer}" \
  --data "custom_id=${consumer}_id"
