#!/bin/bash
if [ $# -lt 2 ]
then
    echo "Usage: k.sh (0|1|dev) N ..."
fi
PROD=$1
shift
BB=$1
shift
kubectl --context rh-production-${PROD}.k8s.local --namespace brokeback-us-${BB} "$@"
