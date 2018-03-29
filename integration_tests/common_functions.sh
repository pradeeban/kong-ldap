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
consumer=Aladdin
apiKey=12345secret
consumerPass=OpenSesame

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

#####################################################
## get user input
#####################################################
function getUserInput() {
    read userInput
    echo ${userInput}
}

#####################################################
## create consumer, return consumer id
#####################################################
function createConsumer() {
    local name=$1
    local tmpFile=/tmp/consumer.json
    curl  -X POST --url ${kong_admin_url}/consumers/ --data "username=${consumerName}" --data "custom_id=${consumerName}_id"> ${tmpFile}
    local id=$(node ../parseJson.js ${tmpFile} "id")
    echo ${id}
}

#####################################################
## create service, return service id
#####################################################
function createService() {
    local name=$1
    local url=$2
    local tmpFile=/tmp/service.json
    curl -X POST --url ${kong_admin_url}/services/ --data "name=${name}" --data "url=${url}" > ${tmpFile}
    local id=$(node ../parseJson.js ${tmpFile} "id")
    echo ${id}
}

#####################################################
## create route on top of service, return service id
#####################################################
function createRoute() {
    local serviceName=$1
    local url=$2
    local tmpFile=/tmp/route.json
    curl -X POST --url ${kong_admin_url}/services/${serviceName}/routes --data "hosts[]=${hosts}" > ${tmpFile}
    local id=$(node ../parseJson.js ${tmpFile} "id")
    echo ${id}
}




