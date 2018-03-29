#!/bin/bash

source ./env

#############################################################
echo "Adding Service(API): name=${name}, url=${url}"

curl -i -X POST \
      --url ${kong_admin_url}/services/ \
      --data "name=${name}" \
      --data "url=${url}"

#############################################################
echo "Adding Route for service:${name} with hosts: ${hosts}"

curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/routes \
      --data "hosts[]=${hosts}"

#############################################################
echo "Configure the key-auth plugin for the service ${name}"

curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=key-auth"

#############################################################
echo "Create a Consumer"

consumerId=$(createConsumer ${consumerName})
echo "Created Consumer Id: ${consumerId}"

#############################################################
echo "Provision key credentials for your Consumer ${consumerName}, id ${consumerId}"

curl -i -X POST \
      --url ${kong_admin_url}/consumers/${consumerId}/key-auth/ \
      --data "key=${apiKey}"

#############################################################

echo "To test: ./test.sh"
