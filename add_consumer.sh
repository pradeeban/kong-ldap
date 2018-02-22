clear
set -x

## Create a Consumer
curl -i -X POST \
  --url http://localhost:8001/consumers/ \
  --data "username=Jason"


## Provision key credentials for your Consumer
## create a key for our recently created consumer Jason by issuing the following request:
curl -i -X POST \
  --url http://localhost:8001/consumers/Jason/key-auth/ \
  --data 'key=12345'


## Verify that your Consumer credentials are valid
##  issue the following request to verify that the credentials of our Jason Consumer is valid:
curl -i -X GET \
  --url http://localhost:8000 \
  --header "Host: example.com" \
  --header "apikey: 12345"
