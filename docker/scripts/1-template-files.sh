#!/usr/bin/env bash
set -e

if [ ! -f "$1" ]; then
  echo "Provide values file as first argument"
  exit 1
fi

function template() {
  docker run -i -v "$PWD":/test --rm hairyhenderson/gomplate -d "values=/test/$1" -f "/test/$2" --out "/test/$3"
}

# conf files
template $1 templates/agent.conf conf/agent.conf
template $1 templates/envoy.conf conf/envoy.conf
template $1 templates/server.conf conf/server.conf

# scripts
template $1 templates/trust-anthem-trust-bundle.sh scripts/2-trust-anthem-trust-bundle.sh
template $1 templates/spire-registration.sh scripts/3-spire-registration.sh