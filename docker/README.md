# Instructions

# Fill out the required variables

Before beginning, the following values need to be determined. You can use the file `example-values.yaml` as a template.

```
internal:
  spire:
    trust_domain: # the trust domain for your spire server
anthem:
  spire:
    trust_domain: # the trust domain for the anthem spire server
    hostname: # hostname of the anthem spire federation endpoint
    port: # port of the anthem spire federation endpoint
  gateway:
    hostname: # hostname of the anthem hos gateway
    port: # port of the anthem hos gateway
```

### Create configuration files from templates

Run `scripts/1-template-files.sh` to generate templates with your values file.

```bash
$ ./scripts/1-template-files.sh example-values.yaml
```

## Create a certificate for your spire-agent

Run the `certs/gencerts.sh` script from this directory, the files `certs/ca.pem, certs/service.pem, and certs/service-key.pem` will be created.

```bash
$ ./certs/gencerts.sh
[INFO] generating a new CA key and certificate from CSR
[INFO] generate received request
...
```

## Launch SPIRE Server

```bash
docker-compose -p spire -f docker-compose.server.yml up -d
```

## Trust the Anthem SPIRE Server

run `scripts/2-trust-anthem.sh` to pull the AnthemAI certificate authority and add it to your spire server.

## Create SPIRE SVID for envoy docker image

Run `scripts/3-spire-registration.sh`, this will create a SPIRE entry/certificate for the envoy container.

## Launch SPIRE Agent and Envoy

```bash
docker-compose -p spire -f docker-compose.services.yml up -d
```

## Expose ports publicly

The docker compose files bind 3 network ports on the host they are run on.

- Port `443` needs to be exposed publicly so Anthem can communicate with the `spire-server` (Ask Anthem employee for our outbound IP's to whitelist them)
- Port `8080` is the local proxy port that is used to talk to the Anthem HealthOS Gateway. This should only be exposed to your local network, not publicly.
- Port `8081` is internal and does not need to be exposed.
