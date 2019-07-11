#!/bin/bash

CLUSTER=$1
WORKSPACE=$2

if [ "$CLUSTER" == "" ]; then
  echo "Missing CLUSTER name."
  exit 1
fi

if [ "$WORKSPACE" == "" ]; then
  WORKSPACE="workspaces"
fi

DOMAIN_NAME="openshiftworkshop.com"

# The project
#oc new-project $WORKSPACE --display-name="$DISPLAY_NAME" --description="$DESCRIPTION"
oc new-project $WORKSPACE
oc project $WORKSPACE

# Nexus
oc new-app sonatype/nexus -n $WORKSPACE
oc rollout pause dc/nexus -n $WORKSPACE
oc expose svc/nexus
oc set probe dc/nexus --liveness --failure-threshold 3 --initial-delay-seconds 180 -- echo ok
oc set probe dc/nexus --readiness --failure-threshold 3 --initial-delay-seconds 120 --get-url=http://:8081/nexus/content/groups/public
oc set volume dc/nexus --add --name 'nexus-volume-1' --type 'pvc' --mount-path '/sonatype-work/' --claim-name 'nexus-data' --claim-size '10G' --overwrite
oc rollout resume dc/nexus -n $WORKSPACE

## Gogs
#oc new-app -f http://bit.ly/openshift-gogs-persistent-template --param APPLICATION_NAME=gogs --param HOSTNAME=gogs-$WORKSPACE.apps.$CLUSTER.$DOMAIN_NAME --param GOGS_VOLUME_CAPACITY=10Gi --param DB_VOLUME_CAPACITY=10Gi --param=SKIP_TLS_VERIFY=true -n $WORKSPACE
oc new-app -f gogs.yaml --param APPLICATION_NAME=gogs --param HOSTNAME=gogs-$WORKSPACE.apps.cluster-$CLUSTER.$CLUSTER.$DOMAIN_NAME --param GOGS_VOLUME_CAPACITY=10Gi --param DB_VOLUME_CAPACITY=10Gi --param=SKIP_TLS_VERIFY=true -n $WORKSPACE

# Jenkins
#oc new-app jenkins-persistent --param ENABLE_OAUTH=true --param MEMORY_LIMIT=2Gi --param VOLUME_CAPACITY=4Gi -n $WORKSPACE
