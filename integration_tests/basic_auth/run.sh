set -x

./add_api.sh
sleep 2

./add_basic_auth_plugin.sh
sleep 2

./add_consumer.sh
sleep 2

./add_credential_for_customer.sh
sleep 2

./test.sh
