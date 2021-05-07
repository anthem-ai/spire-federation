#!/usr/bin/env bash

# add curl
docker exec -it "spire_server_1" apk update
docker exec -it "spire_server_1" apk add curl

# grab trust bundle from anthem
docker exec -it "spire_server_1" /bin/sh -c \
    "curl -k https://{{ (datasource "values").anthem.spire.hostname }}:{{ (datasource "values").anthem.spire.port }} > /tmp/test.json"

# add the trust bundle we downloaded to our certificate store
docker exec -it "spire_server_1" ./bin/spire-server bundle set \
    -format spiffe \
    -id "spiffe://{{ (datasource "values").anthem.spire.trust_domain }}" \
    -path /tmp/test.json
