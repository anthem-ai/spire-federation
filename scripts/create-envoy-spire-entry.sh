#!/usr/bin/env bash

# docker-compose prefixes container names with the parent directory name
BASEDIR=$(basename "$PWD")

docker exec -it "${BASEDIR}_server_1" ./bin/spire-server entry create -parentID spiffe://example.com/spire-agent -spiffeID spiffe://example.com/envoy --selector docker:image_id:envoyproxy/envoy-alpine:v1.14.4 -federatesWith spiffe://hos-prod.k8s.anthemai
