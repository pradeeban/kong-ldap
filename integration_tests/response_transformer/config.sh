## for quick start

source ../common_functions.sh

export module=responsetransformer
export api_name=responseTransformerTestApi
export hosts=response-transformer.com
export consumer_name=responseTransUser
export customer_id=responseTransUser_id

set -x

###### Create API

curl -X POST \
  --url ${kong_admin_url}/apis/ \
  --data "name=${api_name}" \
  --data "hosts=$hosts" \
  --data "upstream_url=http://kong-backend:9090/" \
  --data "preserve_host=false"

sleep 2

###### Add the plugin
curl -X POST \
    --url ${kong_admin_url}/apis/${api_name}/plugins \
    --data "name=response-transformer" \
    --data "config.add.headers[1]=client:allowed" \
    --data "config.add.headers[2]=version:v2"
    
