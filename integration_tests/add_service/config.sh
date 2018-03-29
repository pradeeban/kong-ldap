#!/bin/bash

#  you'll be adding an API to Kong. In order to do this,
# you'll first need to add a Service; that is the name Kong uses to
# refer to the upstream APIs and microservices it manages.
# Before you can start making requests against the Service, you will
# need to add a Route to it. Routes specify how (and if) requests are
# sent to their Services after they reach Kong. A single Service can have many Routes.

source ./env

#############################################################
echo "Adding Service(API): name=${name}, url=${url}"

curl -i -X POST \
      --url ${kong_admin_url}/services/ \
      --data "name=${name}" \
      --data "url=${url}" \

#############################################################
echo "Adding Route for service:${name} with hosts: ${hosts}"

curl -i -X POST \
      --url ${kong_admin_url}/services/${name}/routes \
      --data "hosts[]=${hosts}"

#############################################################

echo "To test: ./test.sh"
