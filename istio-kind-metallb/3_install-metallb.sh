#!/usr/bin/env bash
#
#
#
read -p "Are you sure you want to install metallb in $(kubectl config current-context)? [yesimsure/*]: " && [[ $REPLY != "yesimsure" ]] && exit 1

#
# Your docker cluster network.  Edit ./metallb/metallb-configmap.yaml as needed.
#
read -p "Make sure ./metallb/metal-configmap.yaml ip-pool works with your cluster network: (any key to continue)... "
docker network inspect kind | jq -r '.[0].IPAM.Config[0].Subnet'

kubectl apply -f ./metallb/namespace.yaml
kubectl apply -f ./metallb/metallb-configmap.yaml
kubectl apply -f ./metallb/metallb.yaml



