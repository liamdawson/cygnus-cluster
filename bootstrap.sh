#!/usr/bin/env sh

# I don't want these resources managed as part of the main kustomize stack,
# not least because destroying them will have severe consequences

kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.15.1/cert-manager.yaml
