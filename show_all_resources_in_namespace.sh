#!/usr/bin/env bash

[ -z "$1" ] && echo "You need to provide a namespace" && exit 1

NAMESPACE=$1


grep $NAMESPACE namespace-$NAMESPACE-resources/*.resource | while read resource; do

    extracted_namespace=$(echo $resource | awk '{print $4}')
    [ "$extracted_namespace" == "$NAMESPACE" ] || continue
    resource_type=$(echo "$resource" | sed 's/:.*//g ; s/.*\///g ; s/.resource$//g')
    name=$(echo $resource | awk '{print $3}')

    echo "kubectl get $resource_type $name -n $NAMESPACE -o yaml"
done
