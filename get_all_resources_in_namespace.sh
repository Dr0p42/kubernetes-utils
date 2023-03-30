#!/usr/bin/env bash

[ -z "$1" ] && echo "You need to provide a namespace" && exit 1

NAMESPACE=$1

kubectl api-resources -o=name > api-resources.txt

rm -rf namespace-$NAMESPACE-resources; mkdir namespace-$NAMESPACE-resources

for resource in $(cat api-resources.txt); do
    echo "Getting: $resource"
    kubectl get $resource -o custom-columns=ApiVersion:.apiVersion,Kind:.kind,Name:.metadata.name,Namespace:.metadata.namespace -n $NAMESPACE > namespace-$NAMESPACE-resources/$resource.resource
done

