#!/usr/bin/env bash

# docker-compose prefixes container names with the parent directory name
BASEDIR=$(basename "$PWD")

# add curl
docker exec -it "${BASEDIR}_server_1" apk update
docker exec -it "${BASEDIR}_server_1" apk add curl

# grab trust bundle from anthem
docker exec -it "${BASEDIR}_server_1" /bin/sh -c "curl -k https://spire-federation.aai-hos-dev.anthemai.io:8443 > /tmp/test.json"

# add the trust bundle we downloaded to our certificate store
docker exec -it "${BASEDIR}_server_1" ./bin/spire-server bundle set -format spiffe -id spiffe://hos-dev.k8s.anthemai -path /tmp/test.json
