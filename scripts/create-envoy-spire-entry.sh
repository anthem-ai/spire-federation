#!/usr/bin/env bash

# docker-compose prefixes container names with the parent directory name
BASEDIR=$(basename "$PWD")

docker exec -it "${BASEDIR}_server_1" ./bin/spire-server entry create -parentID spiffe://example.com/spire-agent -spiffeID spiffe://example.com/envoy --selector docker:image_id:200bfdd518ab -federatesWith spiffe://hos-dev.k8s.anthemai
