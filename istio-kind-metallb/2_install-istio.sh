#!/usr/bin/env bash
#
# Install istio in whatever cluster your kubectl is pointing at.  Careful!
#

read -p "Are you sure you want to install istio in $(kubectl config current-context)? [yesimsure/*]: " && [[ $REPLY != "yesimsure" ]] && exit 1
which istioctl || { echo ERROR: istioctl not found in path >&2; exit 1; }

istioctl install 
kubectl label namespace default istio-injection=enabled
