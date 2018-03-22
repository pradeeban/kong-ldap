source ../common_functions.sh
cd ./kong-oauth2-hello-world-master
npm install

## Now that Kong has all the data configured, we can start our application using the 
## provision_key that has been returned when we added the plugin.

## Export the environment variables used by the Node.js application:
export PROVISION_KEY="4aPNuWwcu15AUKbC5fD6nRWLj7BvWhlP"

##export KONG_ADMIN=${kong_admin_url}
##export KONG_API=${kong_api_url}
export KONG_ADMIN="http://127.0.0.1:8001"
export KONG_API="https://127.0.0.1:8443"
export API_PATH="/cats"
export SCOPES="{ \
  \"email\": \"Grant permissions to read your email address\", \
  \"address\": \"Grant permissions to read your address information\", \
  \"phone\": \"Grant permissions to read your mobile phone number\" \
}"

##Note: By default, the application listens on port 3000. You can modify this if you like:
##export LISTEN_PORT=3301

## start the authorization server

node app.js
