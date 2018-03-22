
set -X
echo "Add your API using the Admin API"

curl -i -X POST \
  --url http://localhost:8001/apis/ \
  --data 'name=example-api' \
  --data 'hosts=example.com' \
  --data 'upstream_url=http://mockbin.org'

  echo "Forward your requests through Kong"

  curl -i -X GET \
  --url http://localhost:8000/ \
  --header 'Host: example.com'
