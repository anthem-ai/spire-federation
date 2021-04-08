# Instructions

## Replace the trust domain

Run `scripts/replace-trust-domain.sh` to automatically replace all references of `example.com` with your own trust domain.

## Launch SPIRE Server

```bash
$ docker-compose -f docker-compose.spire-server.yml up -d
```

## Set the AnthemAI trust domain

Run `scripts/trust-anthem-trust-bundle.sh` to pull the AnthemAI Certificate Authority and add it to your spire server.

## Create join token and edit `docker-compose.services.yml`

Run `scripts/create-envoy-spire-entry.sh`, this will create a join token for the spire agent which is used to modify the file below.

Example: `docker-compose.services.yml`
```diff
- - REPLACE_WITH_JOIN_TOKEN
+ - 003c70c7-100c-4345-9b35-b08221ca09a2
```

## Create SPIRE SVID for envoy docker image

Run `scripts/create-envoy-spire-entry.sh`, this will create a SPIRE entry/certificate for the envoy container.

## Launch SPIRE Agent and Envoy

```bash
docker-compose  -f docker-compose.services.yml up -d
```

## Expose ports publicly

The docker compose files bind 3 network ports on the host they are run on.

- Port `443` needs to be exposed publicly so Anthem can communicate with the `spire-server` (Ask Anthem employee for our outbound IP's to whitelist them)
- Port `8080` is the local proxy port that is used to talk to the Anthem HealthOS Gateway. This should only be exposed to your local network, not publicly.
- Port `8081` is internal and does not need to be exposed.
