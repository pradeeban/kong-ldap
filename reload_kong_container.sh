##  Reload Kong in a running container
## If you change your custom configuration, you can reload Kong (without downtime) by issuing:
## This will run the kong reload command in your container
set -x
docker exec -it kong kong reload
