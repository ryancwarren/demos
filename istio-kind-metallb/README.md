# Istio Regex VirtualService Testing w. Metallb
## Requirements
1. kind, docker, istioctl, bash, jq
2. Most likely Linux.  Current (April 5 2022) [kind LB](https://kind.sigs.k8s.io/docs/user/loadbalancer/) docs note issues with OSX & Windows with metallb.

```
1_create_cluster.sh		# create kind cluster and expose container ports for use with istio-gateway.
2_install-istio.sh		# install istio and enable sidecar injection.
3_install-metallb.sh	# not required, but makes it easy to work with istio-ingress.
4_install-demo-app.sh	# Install dummy demo-apps.
demo.sh					# Demo istio routing using regex.
```

## ./test/test.yaml
* Two K8s Deployments with the same app name `demo-app` returning their version on a call to `http://:5678`.
* K8s Service exposing port 9081 to the cluster, targeting port 5678 on pods found via `app: demo-app` selector.
* Destination rule to create subsets for istio-gateway routed traffic.
* Gateway for istio-ingress to route to.
* VirtualService to route requests with `cloud-firm` header matching `.*sdlc-xxx.*` to v1, otherwise route to v2.
