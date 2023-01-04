#!/usr/bin/env bash

# add curl
docker exec "spire-v1-server-1" apk update
docker exec "spire-v1-server-1" apk add curl

# grab trust bundle from anthem
docker exec "spire-v1-server-1" /bin/sh -c \
    "curl -k {{ (datasource "values").carelon.spire.bundle_endpoint_url }} > /tmp/test.json"

# add the trust bundle we downloaded to our certificate store
docker exec "spire-v1-server-1" ./bin/spire-server bundle set \
    -format spiffe \
    -id "spiffe://{{ (datasource "values").carelon.spire.trustDomain }}" \
    -path /tmp/test.json
