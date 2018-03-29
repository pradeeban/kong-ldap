set -x

source ../common_functions.sh

output=/tmp/oauth.log

./add_api.sh > ${output}
sleep 2

./add_oauth_plugin.sh >> ${output}
sleep 2

./add_consumer.sh >> ${output}
sleep 2

./create_oauth_client_app.sh >> ${output}
sleep 2

file1=/tmp/k1.json

url="http://localhost:8001/plugins?name=oauth2"

curl ${url} -o ${file1}

provision_key=$(node parse.js)

echo "PROVISION_KEY=$provision_key"

#### comment out following line
##./start_auth_server.sh


sleep 2

##url="http://127.0.0.1:3000/authorize?response_type=code&scope=email%20address&client_id=helloWorldApp_id"

##/usr/bin/open -a "/Applications/Google Chrome.app" "$url"

set -x
## check client
curl http://localhost:8001/oauth2?client_id=helloWorldApp_id

##  Get authorization code
curl https://localhost:8443/cats/oauth2/authorize \
    --header "Host: mockbin.org" \
    --data "client_id=helloWorldApp_id" \
    --data "response_type=code" \
    --data "scope=email address" \
    --data "authenticated_userid=userid123"  \
    --data "provision_key=${provision_key}" \
    --insecure


echo "Input code from the previous response, followed by [ENTER]:"
code=$(getUserInput)
echo "code=${code}"


curl https://127.0.0.1:8443/cats/oauth2/token \
     --header "Host: mockbin.org" \
     -d "grant_type=authorization_code" \
     -d "client_id=helloWorldApp_id" \
     -d "client_secret=1234Secret" \
     -d "redirect_uri=http://localhost:9090/" \
     -d "code=${code}" \
     --insecure