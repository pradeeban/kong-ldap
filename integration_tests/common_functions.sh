#!/bin/bash

## kong related
export kong_host=localhost
export kong_admin_port=8001
export kong_api_port=8000
export kong_admin_url=http://${kong_host}:${kong_admin_port}
export kong_api_url=http://${kong_host}:${kong_api_port}

##api_name=example-api
## api_hosts=example.com
export api_name=tcia-api
export api_hosts=tcia.org
export upstream_url="http://mockbin.org"

## end of kong related

## LDAP related
export ldap_host=localhost
export ldap_port=10389

## end of LDAP related
