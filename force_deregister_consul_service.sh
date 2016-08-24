#!/bin/bash



SERVICE_NAME=$1



SERVICE_ID=$(curl -X GET http://consul.somewhere.com:8500/v1/catalog/service/"$SERVICE_NAME" \

| python -m json.tool \

| grep ServiceID  \

| awk '{gsub(/"/, ""); gsub(/,/, ""); print $2}')



curl -X PUT http://consul.somewhere.com:8500/v1/agent/service/deregister/"$SERVICE_ID"
