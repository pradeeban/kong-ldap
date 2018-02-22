clear
set -x
curl -i -X POST \
  --url http://localhost:8001/apis/example-api/plugins/ \
  --data 'name=key-auth'

sleep 3
echo " you should get 401 Unauthorized"
curl -i -X GET \
  --url http://localhost:8000/ \
  --header 'Host: example.com'



