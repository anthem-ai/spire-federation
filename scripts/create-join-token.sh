#!/usr/bin/env bash

# docker-compose prefixes container names with the parent directory name
BASEDIR=$(basename "$PWD")

docker exec -it "${BASEDIR}_server_1" ./bin/spire-server token generate -spiffeID spiffe://example.com/spire-agent
