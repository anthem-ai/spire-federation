#!/usr/bin/env bash
set -e

# server
docker run -v "$PWD":/test --rm -i cfssl/cfssl gencert -initca /test/certs/ca.json |
  docker run -v "$PWD":/test --entrypoint=cfssljson --rm -i cfssl/cfssl -bare /test/certs/ca -

# agent
docker run -v "$PWD":/test --rm -i cfssl/cfssl gencert \
    -ca /test/certs/ca.pem \
    -ca-key /test/certs/ca-key.pem \
    -profile service \
    /test/certs/service.json |
      docker run -v "$PWD":/test --entrypoint=cfssljson --rm -i cfssl/cfssl -bare /test/certs/service -
