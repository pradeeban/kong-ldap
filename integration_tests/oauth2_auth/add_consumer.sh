#!/bin/bash

## You need to associate a credential to an existing 
## Consumer object, that represents a user consuming the API.
source ../common_functions.sh

module=oauth2Auth
echo ">>>>>>>>> Adding customer: username=${consumer}_${module}"

set -x
curl -i -X POST \
  --url ${kong_admin_url}/consumers/ \
  --data "username=${consumer}_${module}" \
  --data "custom_id=${consumer}_${module}_id"
