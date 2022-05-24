#!/usr/bin/env bash

# get cert hash
HASH=$(cat certs/service.pem | openssl x509 -outform DER | openssl dgst -sha1 -binary | xxd -p)

docker exec "spire-server-1" ./bin/spire-server entry create \
    -parentID "spiffe://{{ (datasource "values").internal.spire.trust_domain }}/spire/agent/x509pop/${HASH}" \
    -spiffeID "spiffe://{{ (datasource "values").internal.spire.trust_domain }}/envoy" \
    --selector docker:image_id:envoyproxy/envoy-alpine:v1.14.4 \
    -federatesWith "spiffe://{{ (datasource "values").anthem.spire.trust_domain }}"
