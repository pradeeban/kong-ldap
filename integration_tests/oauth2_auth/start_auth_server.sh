
##curl http://localhost:8001/plugins
file1=/tmp/k1.json

url="http://localhost:8001/plugins?name=oauth2"

curl ${url} -o ${file1}

provision_key=$(node parse.js)

echo "PROVISION_KEY=$provision_key"

sed "s/CHANGEME/$provision_key/g" install_authorization_server.sh  > ./tmp_auth.sh

chmod a+x ./tmp_auth.sh
sleep 2

./tmp_auth.sh
