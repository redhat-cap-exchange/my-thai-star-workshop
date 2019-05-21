#!/bin/bash

PROJECT_NAME="mythaistar"
DISPLAY_NAME="My Thai Star"
DESCRIPTION="My Thai Star Cloud Native Workshop"

source scripts/functions.sh

# The project
oc new-project $PROJECT_NAME --display-name="$DISPLAY_NAME" --description="$DESCRIPTION"
oc project $PROJECT_NAME

oc create -f deployments/build-my-thai-star-java.yaml
oc create -f deployments/deploy-my-thai-star-java.yaml

#oc create -f deployments/build-my-thai-star-nodejs.yaml
