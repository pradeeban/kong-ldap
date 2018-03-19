#!/bin/sh

source ${PWD}/common_functions.sh


##curl -X POST ${kong_admin_url}/plugins \
curl -X POST ${kong_admin_url}/apis/${api_name}/plugins \
    --data "name=ldap-auth" \
    --data "config.hide_credentials=true" \
    --data "config.ldap_host=${ldap_host}" \
    --data "config.ldap_port=${ldap_port}" \
    --data "config.base_dn=${base_dn}" \
    --data "config.attribute=uid" \
    --data "config.cache_ttl=2"

  ##  --data "config.cache_ttl=2" \
  ##   --data "config.header_type=ldap"
