#!/bin/bash

CLUSTER=$1

if [ "$CLUSTER" == "" ]; then
  echo "Missing CLUSTER name."
  exit 1
fi

PROJECT_NAME="cicd"
DISPLAY_NAME="CI/CD"
DESCRIPTION="Shared CICD Infrastructure"
DOMAIN_NAME="openshiftworkshop.com"

# The project
#oc new-project $PROJECT_NAME --display-name="$DISPLAY_NAME" --description="$DESCRIPTION"
oc new-project $PROJECT_NAME
oc project $PROJECT_NAME

# Nexus
oc new-app sonatype/nexus -n $PROJECT_NAME
oc rollout pause dc/nexus -n $PROJECT_NAME
oc expose svc/nexus
oc set probe dc/nexus --liveness --failure-threshold 3 --initial-delay-seconds 180 -- echo ok
oc set probe dc/nexus --readiness --failure-threshold 3 --initial-delay-seconds 120 --get-url=http://:8081/nexus/content/groups/public
oc set volume dc/nexus --add --name 'nexus-volume-1' --type 'pvc' --mount-path '/sonatype-work/' --claim-name 'nexus-data' --claim-size '10G' --overwrite
oc rollout resume dc/nexus -n $PROJECT_NAME

## Gogs
oc new-app -f http://bit.ly/openshift-gogs-persistent-template --param APPLICATION_NAME=gogs-$PROJECT_NAME --param HOSTNAME=gogs-$PROJECT_NAME.apps.$CLUSTER.$DOMAIN_NAME --param GOGS_VOLUME_CAPACITY=10Gi --param DB_VOLUME_CAPACITY=10Gi --param=SKIP_TLS_VERIFY=true -n $PROJECT_NAME

# Jenkins
oc new-app jenkins-persistent --param ENABLE_OAUTH=true --param MEMORY_LIMIT=2Gi --param VOLUME_CAPACITY=4Gi -n $PROJECT_NAME

# Codeready Workspaces
cd codeready && ./deploy.sh --deploy --oauth
