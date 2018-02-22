
docker rm -vf kong-database
docker rm -vf kong-migration
docker rm -vf kong-dashboard
docker rm -vf kong

docker rm -vf go-server

docker ps -a |grep -i kong
