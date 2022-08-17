#!/usr/bin/env bash

ingressIp="$(kubectl get service -n istio-system -l app=istio-ingressgateway -o json | jq -rc '.items[0].status.loadBalancer.ingress[0].ip')"

# WARNING: Assuming port 80....


firmNamesToCheck=(
	"pr-1234"
	"firm-nodashbeta"
	"sdlc-canary-us-0001"
	"sdlc-canary-us-0001-beta"
	"sdlc-canary"
	"sdlc-retain-us-0001"			# retain firms not matching is assumed correct behavior.
	"acme-corporation-beta"
)


echo "### v1 means regex matches, v2 means no match ###"
for i in ${firmNamesToCheck[@]}; do 
	
	printf "Trying cloud-firm = %s... result is %s\n" "$i" "$(curl --silent -H "cloud-firm: ${i}" http://${ingressIp}:80)"

done
