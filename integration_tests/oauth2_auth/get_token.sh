
#!/bin/bash

source ../common_functions.sh
set -x
curl https://localhost:8443/oauth2/token \
     -H "Host: test.com" \
     --data "grant_type=authorization_code" \
     --data "client_id=helloWorldApp_id" \
     --data "client_secret=1234Secret" \
     --data "redirect_uri=http://getkong.org/" \
     --data "code=aY6tfpDcVU7n0AnI7FndmAGk9ZhI2qDw" --insecure
