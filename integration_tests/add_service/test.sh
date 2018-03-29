#!/bin/bash

source ./env

set -x

curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${hosts}"
