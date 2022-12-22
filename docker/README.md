# Docker Instructions

## Customize Variables

Before proceeding, some variables specific to your configuration will need to be set. Copy `example.values.yaml` to a 
new file (ie: `values.yaml`) and update all values that are set to `REPLACE_ME`:

```yaml
########### CUSTOMIZE VALUES IN THIS SECTION ###########

# The trust domain for your SPIRE server (ie: example.org)
partnerTrustDomain: REPLACE_ME
partnerShortName: REPLACE_ME
carelon:
  spire:
    # The trust domain for the Carelon SPIRE server
    trustDomain: REPLACE_ME
    # Full URL for SPIRE trust bundle
    bundle_endpoint_url: REPLACE_ME
  gateway:
    # Hostname of the Carelon HOS gateway
    host: REPLACE_ME
federation:
  service:
    # Domain that will be trusted by letsencrypt (only required if letsencrypt is true)
    hostname: REPLACE_ME
    # Admin email used by letsencrypt
    admin_email: REPLACE_ME

########### END CUSTOMIZED VALUES ###########
```

## Create a certificate for the partner SPIRE Agent

Run the following from the project root to generate certificate files. The files `certs/ca.pem`, `certs/service.pem`, 
and `certs/service-key.pem` will be created:

```shell
./certs/gencerts.sh
[INFO] generating a new CA key and certificate from CSR
[INFO] generate received request
```

## Create configuration files from templates

Run the following to generate templates with your customized values file.

```shell
./scripts/1-template-files.sh values.yaml
```

## Launch the partner SPIRE Server

```shell
docker compose -p spire-v1 -f docker-compose.server.yaml up -d
```

## Trust the Carelon SPIRE Server

Run the following to pull the Carelon certificate authority and add it to your SPIRE server:

```shell
chmod +x ./scripts/2-trust-carelon-trust-bundle.sh
./scripts/2-trust-carelon-trust-bundle.sh
```

## Create SPIRE SVID for proxy docker image

Run the following to create a SPIRE entry/certificate for the proxy container:

```shell
chmod +x ./scripts/3-spire-registration.sh
./scripts/3-spire-registration.sh
```

## Launch SPIRE Agent and Proxy

```shell
docker compose -p spire-v1 -f docker-compose.services.yaml up -d
```

## Expose ports publicly

The docker compose files bind 3 network ports on the host they are run on.

- Port `443` needs to be exposed publicly so Carelon can communicate with the `spire-server` (Ask Carelon employee for 
their outbound IP's to whitelist them)
- Port `8080` is the local proxy port that is used to talk to the Carelon HealthOS Gateway. This should only be exposed
to your local network, not publicly.
- Port `8081` is internal and does not need to be exposed.
