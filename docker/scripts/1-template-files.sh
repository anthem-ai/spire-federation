#!/usr/bin/env bash
set -e

if [ ! -f "$1" ]; then
  echo "Provide values file as first argument"
  exit 1
fi

function template() {
  docker run -i -v "$PWD":/test --rm hairyhenderson/gomplate -d "values=/test/$1" -f "/test/$2" --out "/test/$3"
}

# docker compose files
template $1 templates/docker-compose.server.yaml ./docker-compose.server.yaml
template $1 templates/docker-compose.services.yaml ./docker-compose.services.yaml

# conf files
template $1 templates/agent.conf conf/agent.conf
template $1 templates/server.conf conf/server.conf

# scripts
template $1 templates/trust-carelon-trust-bundle.sh scripts/2-trust-carelon-trust-bundle.sh
template $1 templates/spire-registration.sh scripts/3-spire-registration.sh