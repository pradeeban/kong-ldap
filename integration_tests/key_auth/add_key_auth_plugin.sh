#!/bin/sh

source ../common_functions.sh

module=keyAuth
plugin=key-auth
echo "....... Adding plugin: $plugin"
##curl -X POST ${kong_admin_url}/plugins \
set -x
curl -X POST ${kong_admin_url}/apis/${api_name}_${module}/plugins \
    --data "name=${plugin}" \
    --data "config.hide_credentials=true"
