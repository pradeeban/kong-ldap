#!/bin/sh

source ${PWD}/common_functions.sh

echo "List all apis"
curl -i ${kong_admin_url}/plugins
