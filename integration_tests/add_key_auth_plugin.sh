#!/bin/sh

source ${PWD}/common_functions.sh

plugin=key-auth
echo "....... Adding plugin: $plugin"
##curl -X POST ${kong_admin_url}/plugins \
curl -X POST ${kong_admin_url}/apis/${api_name}/plugins \
    --data "name=key-auth"
