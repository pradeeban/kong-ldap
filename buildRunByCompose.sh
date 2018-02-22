set -x
./delete_containers.sh
export KONG_VERSION=latest

docker build . -t gobuild

docker run  -p 3000:3000 --name go-server -dit gobuild

docker-compose up

docker ps
