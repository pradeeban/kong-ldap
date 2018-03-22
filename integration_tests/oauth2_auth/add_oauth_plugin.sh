#!/bin/sh

## Once applied, any user with a valid credential can access 
## the service/API. To restrict usage to only some of the 
## authenticated users, also add the ACL plugin 
## and create whitelist or blacklist groups of users.

source ../common_functions.sh

module=oauth2Auth
plugin=oauth2
echo "....... Adding plugin: $plugin"

set -x
curl -X POST ${kong_admin_url}/apis/${api_name}_${module}/plugins \
    --data "name=${plugin}" \
    --data "config.enable_authorization_code=true" \
    --data "config.scopes=email,phone,address" \
    --data "config.mandatory_scope=true"
