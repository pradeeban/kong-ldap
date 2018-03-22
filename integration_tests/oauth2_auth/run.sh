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

echo "Get provision_key from ${output}, and update in install_authorization_server.sh "
echo "Run ./install_authorization_server.sh"
##./test_credential.sh
