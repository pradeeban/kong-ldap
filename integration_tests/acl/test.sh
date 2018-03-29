## for quick start

source ./env

echo "Verify that valid Consumer Credential are valid"

set -x 

curl -i -X GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}" \
      --header "apikey: ${apiKey}"

echo "You should see 'Backend Resource Response ...' message"
echo ""


echo "Verify that valid Consumer Credential are Not valid"
curl -i -X GET \
      --url ${kong_api_url}     \
      --header "Host: ${hosts}" \
      --header "apikey: ${apiKey}_bad"

echo "You should see 'You cannot consume this service' message"
