set -x
cd ..
./add_api.sh
sleep 3
cd - 

./add_key_auth_plugin.sh
sleep 3

./add_consumer.sh
sleep 3

./add_key_for_consumer.sh
sleep 3

./test_api_key.sh
