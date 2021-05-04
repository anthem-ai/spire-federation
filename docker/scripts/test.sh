#!/usr/bin/env bash

bold=$(tput bold) || true
norm=$(tput sgr0) || true
red=$(tput setaf 1) || true
green=$(tput setaf 2) || true

cleanup() {
    echo "${green}Cleaning up...${norm}"
    docker-compose -p spire -f docker-compose.services.yml down
    docker-compose -p spire -f docker-compose.server.yml down
    rm -Rf conf/*
    rm -Rf certs/*.csr
    rm -Rf certs/*.pem
}

cleanup
./certs/gencerts.sh

./scripts/1-template-files.sh example-values.yaml

docker-compose -p spire -f docker-compose.server.yml up -d
./scripts/2-trust-anthem.sh
./scripts/3-spire-registration.sh

docker-compose -p spire -f docker-compose.services.yml up -d

docker logs -f spire_agent_1
wait

cleanup