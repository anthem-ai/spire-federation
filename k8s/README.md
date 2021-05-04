# Instructions

# Fill out the required variables

Before beginning, the following values need to be determined. You can use the file `values.yaml` as a template.

```
trustedDomain: # the trust domain for your spire server
anthem:
  spire:
    trust_domain: # the trust domain for the anthem spire server
    hostname: # hostname of the anthem spire federation endpoint
    port: # port of the anthem spire federation endpoint
  gateway:
    hostname: # hostname of the anthem hos gateway
    port: # port of the anthem hos gateway
```

## Install Helm Chart

```bash
$ helm install spire -f values.yaml .
Release "spire" has been installed. Happy Helming!
NAME: spire
...
```

## Bootstrap the server

Inside the `spire-server-0` pod, run the `/run/spire/bootstrap/bootstrap.sh` script to pull the anthem trust bundle and create the envoy spire entry.

```bash
$ kubectl exec -it spire-server-0 /run/spire/bootstrap/bootstrap.sh
...
```