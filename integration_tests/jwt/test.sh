#!/usr/bin/env bash
## for quick start

source ../common_functions.sh

module=jwt
api_name=jwttestapi
consumer_name=jeff
customer_id=jeff_id


set -X

###### Create API

curl -X POST \
  --url ${kong_admin_url}/apis/ \
  --data "name=${api_name}" \
  --data "uris=/jwttestapi" \
  --data "hosts=mockbin.org" \
  --data "upstream_url=http://mockbin.org/" \
  --data "preserve_host=false"

sleep 2

###### Configure jwt config
curl -X POST \
   --url ${kong_admin_url}/apis/${api_name}/plugins \
   --data "name=jwt"

###### Create a Consumer
curl -X POST \
  --url ${kong_admin_url}/consumers/ \
  --data "username=${consumer_name}" \
  --data "custom_id=${customer_id}"


###### Create a JWT Credential: provision a new HS256 JWT credential
curl -X POST \
  --url ${kong_admin_url}/consumers/${consumer_name}/jwt \
  -H "Content-Type: application/x-www-form-urlencoded"

  ## {"created_at":1521737676000,"id":"68e617c2-da27-44aa-a1f5-ff1fa8d3b810","algorithm":"HS256","key":"XrgAlPdmJAmpvdZYaCNi4rZ6hKqSB5T7","secret":"2X1eydMt4oN4u04iooIo9MXm6IeseO5N","consumer_id":"1b310b86-5a2e-42ca-aaf9-d97d9be33486"}

jwtToken=J0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJYcmdBbFBkbUpBbXB2ZFpZYUNOaTRyWjZoS3FTQjVUNyIsInVzZXJuYW1lIjoiamVmZiJ9.DExR2htbbd1IP3vcFif-asNn1zh2d1PRteMdd4UxWDI
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJYcmdBbFBkbUpBbXB2ZFpZYUNOaTRyWjZoS3FTQjVUNyIsInVzZXJuYW1lIjoiamVmZiJ9.EJMeYVMEUg5uSm0OdykMA0aCURa1ClIpvQwyaKUNZG0

jwtToken=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJYcmdBbFBkbUpBbXB2ZFpZYUNOaTRyWjZoS3FTQjVUNyIsInVzZXJuYW1lIjoiamVmZiJ9.EJMeYVMEUg5uSm0OdykMA0aCURa1ClIpvQwyaKUNZG0
curl -i http://localhost:8000/jwttestapi \
  -H "Authorization: Bearer $jwtToken}" \
  --header "Host: mockbin.org" 
