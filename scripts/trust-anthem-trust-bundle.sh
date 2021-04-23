#!/usr/bin/env bash

# docker-compose prefixes container names with the parent directory name
BASEDIR=$(basename "$PWD")

# add curl
docker exec -it "${BASEDIR}_server_1" apk update
docker exec -it "${BASEDIR}_server_1" apk add curl

# grab trust bundle from anthem
docker exec -it "${BASEDIR}_server_1" /bin/sh -c "curl -k https://thos-hos-spire-federated-elb-1374501979.us-east-1.elb.amazonaws.com > /tmp/test.json"

# add the trust bundle we downloaded to our certificate store
docker exec -it "${BASEDIR}_server_1" ./bin/spire-server bundle set -format spiffe -id spiffe://hos-prod.k8s.anthemai -path /tmp/test.json
