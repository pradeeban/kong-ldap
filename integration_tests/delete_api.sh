#!/bin/sh
set -x
source ${PWD}/common_functions.sh

echo "Deleting API: api_name=$api_name"


curl -i -X DELETE ${kong_admin_url}/apis/${api_name}

echo "List all apis"
curl -i ${kong_admin_url}/apis
