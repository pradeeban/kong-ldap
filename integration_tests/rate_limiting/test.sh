## for quick start

source ./env

echo "Test X-RateLimit from the response"
curl -i -X  GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}"

echo "Watch 'X-RateLimit-Remaining-hour: ' from the response"
