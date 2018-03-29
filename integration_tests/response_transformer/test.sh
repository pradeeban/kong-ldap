## for quick start

source ./env

set -x

curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${hosts}" 

  sleep 2
  
  docker logs kong-backend

  echo ""
  curl -i -X GET \
  --url ${kong_api_url} \
  --header "Host: ${hosts}" 