set -x
./delete_containers.sh
sleep 5
docker ps -a

##./install_cassandra.sh
./install_postgres.sh
sleep 6
docker ps -a

./apply_migration.sh
sleep 8 
docker ps -a

./install_kong.sh

##docker build . -t gobuild
##docker run  -p 3000:3000 --name go-server -dit gobuild
sleep 2
clear
docker ps -a
