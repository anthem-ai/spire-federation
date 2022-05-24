#!/usr/bin/env bash

# add curl
docker exec "spire-server-1" apk update
docker exec "spire-server-1" apk add curl

# grab trust bundle from anthem
docker exec "spire-server-1" /bin/sh -c \
    "curl -k https://{{ (datasource "values").anthem.spire.hostname }}:{{ (datasource "values").anthem.spire.port }} > /tmp/test.json"

# add the trust bundle we downloaded to our certificate store
docker exec "spire-server-1" ./bin/spire-server bundle set \
    -format spiffe \
    -id "spiffe://{{ (datasource "values").anthem.spire.trust_domain }}" \
    -path /tmp/test.json
