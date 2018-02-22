## Start a PostgreSQL container by executing:

set -x

docker run -d --name kong-database \
              -p 5432:5432 \
              -e "POSTGRES_USER=kong" \
              -e "POSTGRES_DB=kong" \
              postgres:9.5

docker ps |grep kong-database
