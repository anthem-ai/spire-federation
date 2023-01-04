#!/usr/bin/env bash

# get cert hash
HASH=$(cat certs/service.pem | openssl x509 -outform DER | openssl dgst -sha1 -binary | xxd -p)

docker exec "spire-v1-server-1" ./bin/spire-server entry create \
    -parentID "spiffe://{{ (datasource "values").partnerTrustDomain }}/spire/agent/x509pop/${HASH}" \
    -spiffeID "spiffe://{{ (datasource "values").partnerTrustDomain }}/hos-proxy" \
    --selector docker:image_id:ghostunnel/ghostunnel:{{ (datasource "values").proxy.image.tag }} \
    -federatesWith "spiffe://{{ (datasource "values").carelon.spire.trustDomain }}"
