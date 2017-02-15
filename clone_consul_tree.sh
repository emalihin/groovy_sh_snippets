#!/bin/bash

# PELASE NOTE THAT JQ >1.4 SHOULD BE IN $PATH !

# ALSO TAKE NOTE OF THE CONSUL PATH IN CURL 
# STATEMENT AND CHANGE AS REQUIRED

FROM=ORIGINAL_NAME
TO=TARGET_NAME

curl http://consul.somewhere.com:8500/v1/kv/dbconns/$FROM\?recurse 2>/dev/null |
jq -r '.[] | [.Key, .Value] | join(" ")' |
while read line; do
    KEY=$(echo $line | awk '{print $1}' | sed "s/$FROM/$TO/")
    VAL=$(echo $line | awk '{print $2}' | base64 --decode)
    curl -XPUT -d "$VAL" "http://consul.somewhere.com:8500/v1/kv/$KEY"
    echo
done
