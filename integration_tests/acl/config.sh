#!/usr/bin/env bash

# Restrict access to a Service or a Route (or the deprecated API entity)
# by whitelisting or blacklisting consumers using arbitrary ACL group names.
# This plugin requires an [authentication plugin][faq-authentication]
# to have been already enabled on the Service or the Route (or API).


source ../common_functions.sh

export module=acl
export name=${module}_srv
export url=${upstream_url}
export hosts=${module}.org
export route_id=""
export consumerName=${module}_consumer
export key=${consumerName}_secret_key

echo "Adding Service: name=${name}, url=${url}"
curl -i -X POST \
      --url ${kong_admin_url}/services/    \
      --data "name=${name}"                 \
      --data "url=${url}"

echo "Add acl plugin with whitelist: group1, group2 on top of a Service ${name}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=acl"             \
      --data "config.whitelist=group1, group2"

echo "Adding Route for service:${name} with hosts: ${hosts}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/routes    \
      --data "hosts[]=${hosts}"

if [ -z "$route_id" ]
then

      echo "Input route id (id from the previous response), followed by [ENTER]:"
      read route_id
      echo "routeId is ${route_id}"
else
      echo "route id $route_id"
fi

echo "Enable acl plugin for Route for service:${name} with hosts: ${hosts} on top of a Route "
curl -i -X POST \
      --url ${kong_admin_url}/routes/${route_id}/plugins       \
      --data "name=acl"  \
      --data "config.whitelist=group1, group2"


echo "Enable Key-Auth plugin on Service: ${name}"
curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins   \
      --data name=key-auth

echo "Create a Valid Consumer"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/         \
      --data "username=${consumerName}"          \
      --data "custom_id=${consumerName}_id"


echo "Associating Valid Consumer ${consumerName} with acl"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/${consumerName}/acls    \
      --data "group=group1"

echo "Provision Key Credential for valid Consumer: ${consumerName}"
curl -X POST \
      --url ${kong_admin_url}/consumers/${consumerName}/key-auth   \
      --data "key=${key}"


echo "Verify that valid Consumer Credential are valid"
curl -X GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}" \
      --header "apikey: ${key}"

echo "You should see 'Backend Resource Response ...' message"
echo ""

###### Create Non Valid Consumer

echo "Create a Non Valid Consumer"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/         \
      --data "username=${consumerName}_bad"          \
      --data "custom_id=${consumerName}_bad_id"


echo "Associating Valid Consumer ${consumerName}_bad with acl"
curl -i -X POST \
      --url ${kong_admin_url}/consumers/${consumerName}_bad/acls    \
      --data "group=group100"

echo "Provision Key Credential for non valid Consumer: ${consumerName}_bad"
curl -X POST \
      --url ${kong_admin_url}/consumers/${consumerName}_bad/key-auth   \
      --data "key=${key}_bad"


echo "Verify that valid Consumer Credential are Not valid"
curl -X GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}" \
      --header "apikey: ${key}_bad"

echo "You should see 'You cannot consume this service' message"