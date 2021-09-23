#!/bin/bash
if [ $# -lt 2 ]
then
    echo "Usage: k.sh (0|1|dev) N ..."
fi
PROD=$1
shift
SHARD=$1
shift

if [ $PROD -eq 0 ]
then
  PROD=
else
  PROD=-$PROD
fi

if [[ $SHARD != "meiosis" && $SHARD != "helios" ]]
then
  SHARD=brokeback-us-$SHARD
fi

kubectl --context rh-production${PROD}.k8s.local --namespace ${SHARD} "$@"
