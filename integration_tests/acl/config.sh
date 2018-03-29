#!/usr/bin/env bash

# Restrict access to a Service or a Route (or the deprecated API entity)
# by whitelisting or blacklisting consumers using arbitrary ACL group names.
# This plugin requires an [authentication plugin][faq-authentication]
# to have been already enabled on the Service or the Route (or API).


source ./env

#############################################################
echo "Adding Service(API): name=${name}, url=${url}"
serviceId=$(createService ${name} ${url})
echo "Created service Id: ${serviceId}"

sleep 3

#############################################################
echo "Add acl plugin with whitelist: group1, group2 on top of a Service ${name}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=acl"             \
      --data "config.whitelist=group1, group2"


#############################################################
echo "Adding Route for service:${name} with hosts: ${hosts}"
routeId=$(createRoute ${name} ${hosts})
echo "Created route Id: ${routeId}"

sleep 3

#############################################################
echo "Enable acl plugin for Route for service:${name} with hosts: ${hosts} on top of a routeId: ${routeId} "
curl -i -X POST \
      --url ${kong_admin_url}/routes/${routeId}/plugins       \
      --data "name=acl"  \
      --data "config.whitelist=group1, group2"

sleep 3

#############################################################
echo "Enable Key-Auth plugin on Service: ${name}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins   \
      --data name=key-auth

sleep 3

#############################################################
echo "Create a Valid Consumer"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/         \
      --data "username=${consumerName}"          \
      --data "custom_id=${consumerName}_id"

sleep 3

#############################################################
echo "Associating Valid Consumer ${consumerName} with acl"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/${consumerName}/acls    \
      --data "group=group1"

sleep 3

#############################################################
echo "Provision Key Credential for valid Consumer: ${consumerName}"
curl -X POST \
      --url ${kong_admin_url}/consumers/${consumerName}/key-auth   \
      --data "key=${apiKey}"


sleep 3

#############################################################
echo "Create a Non Valid Consumer who is not in the whitelist"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/         \
      --data "username=${consumerName}_bad"          \
      --data "custom_id=${consumerName}_bad_id"

sleep 3

#############################################################
echo "Associating non Valid Consumer ${consumerName}_bad with acl"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/${consumerName}_bad/acls    \
      --data "group=group100"

sleep 3

#############################################################
echo "Provision Key Credential for non valid Consumer: ${consumerName}_bad"
curl -X POST \
      --url ${kong_admin_url}/consumers/${consumerName}_bad/key-auth   \
      --data "key=${apiKey}_bad"

#####################################################
echo "To test: ./test.sh"
