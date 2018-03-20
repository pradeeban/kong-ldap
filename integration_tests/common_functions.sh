#!/bin/bash

######## kong admin/application related
export kong_host=localhost
export kong_admin_port=8001
export kong_api_port=8000
export kong_admin_url=http://${kong_host}:${kong_admin_port}
export kong_api_url=http://${kong_host}:${kong_api_port}

######## end of kong admin/application related

######## kong api related
export api_name=tcia_api
export api_hosts=tcia_server
##export upstream_url="http://mockbin.org"
##export upstream_url="http://go-server:3000"
export upstream_url="http://kong-backend:9090"

######## end of kong api related

######## consumer related
consumer=annie
apiKey=12345secret

## LDAP related
##export ldap_host=localhost
export ldap_host=kong-ldap
export ldap_host=lion.bmi.emory.edu
##export ldap_host=ldap.forumsys.com
##export ldap_port=10389
export ldap_port=389
## end of LDAP related
##export base_dn="dc=openmicroscopy,dc=org"
export base_dn="dc=springframework,dc=org"
