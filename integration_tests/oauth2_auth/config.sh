set -x

output=/tmp/oauth.log

./add_api.sh > ${output}
sleep 2

./add_oauth_plugin.sh >> ${output}
sleep 2

./add_consumer.sh >> ${output}
sleep 2

./create_oauth_client_app.sh >> ${output}
sleep 2

provision_key=$(node parse.js)


./start_auth_server.sh


##sleep 2

##url="http://127.0.0.1:3000/authorize?response_type=code&scope=email%20address&client_id=helloWorldApp_id"

##/usr/bin/open -a "/Applications/Google Chrome.app" "$url"