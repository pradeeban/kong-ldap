#!/bin/bash

source ./env

cd ./gs-spring-boot-docker/complete
## ./mvnw package && java -jar target/gs-spring-boot-docker-0.1.0.jar
./mvnw package
./mvnw install dockerfile:build
docker run --name kong-backend -d -p 9090:9090 -t springio/gs-spring-boot-docker
