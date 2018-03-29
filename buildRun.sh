#!/bin/bash

source ./env

logfile=${KONG_LOG_FILE}

echo "Kong log file: ${logfile}"

./install_all.sh 2>&1 | tee  ${logfile}