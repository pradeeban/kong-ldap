#!/bin/bash

source ${PWD}/common_functions.sh

curl -X GET http://localhost:8001/status
