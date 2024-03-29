# Kubernetes Instructions

## Customize Variables

Before proceeding, some variables specific to your configuration will need to be set.

Make a file for your custom values. Copy `example.values.yaml` to a
new file (ie: `custom_values.yaml`) and update all values that are set to `REPLACE_ME`:

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
  letsencrypt: true
  service:
    type: NodePort
    nodePort: REPLACE_ME
    # Domain that will be trusted by letsencrypt (only required if letsencrypt is true)
    hostname: REPLACE_ME
    # Admin email used by letsencrypt
    admin_email: REPLACE_ME

########### END CUSTOMIZED VALUES ###########
```

## Set K8s Context and Create Namespace

Set the context for the target cluster where SPIRE will run and create namespace:

```shell
kubectl config use-context <YOUR_CLUSTER>
kubectl create namespace spire-v1
```

## Install Helm Chart

```shell
# Use the values file corresponding to the desired federation environment
helm install spire-v1 -n spire-v1 -f values.yaml -f custom_values.yaml .
Release "spire-v1" has been installed. Happy Helming!
NAME: spire-v1
```