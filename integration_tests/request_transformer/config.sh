## for quick start

source ./env



set -x

###### Create API

curl -X POST \
  --url ${kong_admin_url}/apis/ \
  --data "name=${api_name}" \
  --data "hosts=$hosts" \
  --data "upstream_url=http://kong-backend:9090/" \
  --data "preserve_host=false"

sleep 2

###### Configure  config
curl -X POST \
    --url ${kong_admin_url}/apis/${api_name}/plugins \
    --data "name=request-transformer" \
    --data "config.add.headers[1]=h1:v1" \
    --data "config.add.headers[2]=h2:v2"
    
