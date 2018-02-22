## Start a Cassandra containers by executing:
set -x

docker run -d --name kong-database \
                -p 9042:9042 \
                cassandra:3

docker ps |grep kong-database
