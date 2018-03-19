#!/bin/bash

source ${PWD}/common_functions.sh

echo ">>>>>>>>> Adding customer: username=$plugin"

curl -i -X POST \
  --url ${kong_admin_url}/consumers/ \
  --data "username=${consumer}"
