# Cluster Infrastructure

The goal is to provide the following components, used by **TODO**

- `private` ingress

## Setup

```shell
kustomize build prod/cygnus | kubectl apply -f -
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
```

## Environments

- `prod/cygnus`
