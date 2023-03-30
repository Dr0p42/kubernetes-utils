#!/usr/bin/env bash

kubectl api-resources -o=name > api-resources.txt

rm -rf finalizers; mkdir finalizers

for resource in $(cat api-resources.txt); do
    echo "Getting: $resource"
    kubectl get $resource -o custom-columns=ApiVersion:.apiVersion,Kind:.kind,Name:.metadata.name,Finalizers:.metadata.finalizers,Namespace:.metadata.namespace --all-namespaces > finalizers/$resource.finalizers
done

