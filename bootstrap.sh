#!/usr/bin/env sh

# it's infeasible (and probably inadvisable) to convert these to Tanka format
# so apply them through a different process

kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.15.1/cert-manager.yaml
