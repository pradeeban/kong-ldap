#!/bin/sh

source ${PWD}/common_functions.sh

base_dn="dc=lab,dc=bmi,dc=emory,dc=edu"
##curl -X POST ${kong_admin_url}/plugins \
curl -X POST ${kong_admin_url}/apis/${api_name}/plugins \
    --data "name=ldap-auth" \
    --data "config.hide_credentials=true" \
    --data "config.ldap_host=${ldap_host}" \
    --data "config.ldap_port=${ldap_port}" \
    --data "config.base_dn=${base_dn}" \
    --data "config.attribute=cn" \
    --data "config.cache_ttl=60" \
    --data "config.header_type=ldap"
