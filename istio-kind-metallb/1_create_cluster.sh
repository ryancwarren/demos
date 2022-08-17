#!/usr/bin/env bash

#
# Create the cluster, expose 30000 30443 on localhost (see docker container ls to validate).
#
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 80
    hostPort: 30000
    protocol: TCP
  - containerPort: 443
    hostPort: 30443 
    protocol: TCP
EOF
