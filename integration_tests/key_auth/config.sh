#!/bin/bash

source ./env

#############################################################
echo "Adding Service(API): name=${name}, url=${url}"

curl -i -X POST \
      --url ${kong_admin_url}/services/ \
      --data "name=${name}" \
      --data "url=${url}"

sleep 2

#############################################################
echo "Adding Route for service:${name} with hosts: ${hosts}"

curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/routes \
      --data "hosts[]=${hosts}"

sleep 2

#############################################################
echo "Configure the key-auth plugin for the service ${name}"

curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/plugins \
      --data "name=key-auth"

sleep 2

#############################################################
echo "Create a Consumer"

consumerId=$(createConsumer ${consumerName})
echo "Created Consumer Id: ${consumerId}"

sleep 2

#############################################################
echo "Provision key credentials for your Consumer ${consumerName}, id ${consumerId}"

curl -i -X POST \
      --url ${kong_admin_url}/consumers/${consumerId}/key-auth/ \
      --data "key=${apiKey}"

sleep 2

#############################################################

echo "To test: ./test.sh"
