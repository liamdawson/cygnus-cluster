#!/usr/bin/env sh

# I don't want these resources managed as part of the main kustomize stack,
# not least because destroying them will have severe consequences

kubectl apply -f vendor/cert-manager.yaml
