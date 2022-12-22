Any third party that wishes to federate with the Carelon HOS Application needs to run SPIRE within their environment.

These requirements must be met before Federation work can begin:
- Linux Environment
- Docker or Kubernetes
- Persistent Storage (PVC in Kubernetes)
- The ability to expose TCP services (not HTTP/Layer 7)
 
In this repo, we have `Docker` and  `Kubernetes` labs for federating with HOS.

To install SPIRE using Docker, please see the Docker [README.md](./docker/README.md).

To install SPIRE using Kubernetes, please see the Kubernetes [README.md](./k8s/README.md).

![](architecture.png)
